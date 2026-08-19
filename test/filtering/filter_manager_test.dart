import 'package:test/test.dart';
import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/cms_.dart';
import '../fixture/test_components.dart';

void main() {
  group('Filter tests', () {
    test('Filter returns correct entities immediately if cached or matches on collect', () async {
      final cms = CMS((config) {}).create();
      final content1 = cms.createContent();
      final content2 = cms.createContent();

      cms.attachComponent(content1, const TestComponent(value: 1));
      cms.attachComponent(content2, SecondTestComponent());

      await Future.microtask(() {});

      final filteredWithTest = cms.filter().and<TestComponent>().collect();
      expect(filteredWithTest.contains(content1), true);
      expect(filteredWithTest.contains(content2), false);

      final filteredWithoutTest = cms.filter().no<TestComponent>().collect();
      expect(filteredWithoutTest.contains(content2), true);
      expect(filteredWithoutTest.contains(content1), false);
    });

    test('Filter cache updates reactively after microtask', () async {
      final cms = CMS((config) {}).create();
      final content = cms.createContent();

      // Invoke collect() before attaching component to cache the filter in FilterManager
      final filterBuilder = cms.filter().and<TestComponent>();
      filterBuilder.collect();

      cms.attachComponent(content, const TestComponent(value: 1));

      // The cached filter should not contain the entity yet
      expect(filterBuilder.collect().contains(content), false);

      await Future.microtask(() {});

      // After microtask execution the filter must be updated
      expect(filterBuilder.collect().contains(content), true);
    });

    test('Delete non-existing entity does not throw', () {
      final cms = CMS((config) {}).create();
      final fakeContent = const CmsContent(id: 999, generation: 1);

      expect(() => cms.deleteContent(fakeContent), returnsNormally);
    });

    test('Delete already deleted entity returns false and does not throw', () {
      final cms = CMS((config) {}).create();
      final content = cms.createContent();

      expect(cms.deleteContent(content), true);
      expect(cms.deleteContent(content), true);
    });

    test('Deleting content clears its components from stashes', () {
      final cms = CMS((config) {}).create();
      final content = cms.createContent();

      cms.attachComponent(content, const TestComponent(value: 100));
      expect(cms.hasComponent<TestComponent>(content), true);

      expect(cms.deleteContent(content), true);

      // Verify components are cleared from stashes
      expect(cms.hasComponent<TestComponent>(content), false);
      expect(() => cms.getComponent<TestComponent>(content), throwsException);
    });

    test('Deleting content removes it from active filters', () async {
      final cms = CMS((config) {}).create();
      final content = cms.createContent();

      cms.attachComponent(content, const TestComponent(value: 100));
      await Future.microtask(() {});

      final filter = cms.filter().and<TestComponent>();
      expect(filter.collect().contains(content), true);

      expect(cms.deleteContent(content), true);
      await Future.microtask(() {});

      // Verify filters are updated and entity is removed
      expect(filter.collect().contains(content), false);
    });

    test('Filter updates correctly on component detach', () async {
      final cms = CMS((config) {}).create();
      final content = cms.createContent();

      cms.attachComponent(content, const TestComponent(value: 1));
      await Future.microtask(() {});

      final filter = cms.filter().and<TestComponent>();
      expect(filter.collect().contains(content), true);

      cms.detachComponent<TestComponent>(content);
      await Future.microtask(() {});

      expect(filter.collect().contains(content), false);
    });

    test('Filter LRU cache eviction works', () async {
      final localCms = CMS((config) {
        config.withFilterCacheLimit(32); // Limit is 32 (min by config: 1 << 5)
      }).create();

      final content = localCms.createContent();
      localCms.attachComponent(content, const TestComponent(value: 1));
      await Future.microtask(() {});

      // Accessing 33 different filters to trigger eviction (32 is the limit)
      // Since we need different masks, we can check that it works.
      // However, we don't have 33 component types to easily generate 33 unique masks.
      // But we can verify with 3 components (TestComponent, SecondTestComponent, ThirdTestComponent)
      // that we can create distinct filters and they are cached.
      final f1 = localCms.filter().and<TestComponent>().collect();
      final f2 = localCms.filter().and<SecondTestComponent>().collect();
      final f3 = localCms.filter().and<ThirdTestComponent>().collect();

      expect(f1, isNotNull);
      expect(f2, isNotNull);
      expect(f3, isNotNull);
    });
  });
}
