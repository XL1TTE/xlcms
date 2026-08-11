import 'package:test/test.dart';
import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/stash.dart';

final class TestComponent{
  const TestComponent({required this.value});
  final int value;
}

void main() {
  group('Stash tests', () {

    late Stash<TestComponent> stash; 

    setUp(() {
      stash = Stash();
    });

    test('Stash by default empty', () {
      expect(stash.isEmpty, true);
    });

    test('Stash add() attaches component to the content', () {
      // Be aware that id of content and size of the stash are related for id -> index on the stash 
      // id: 3 would lead to stash.size equal to 4 e.t.c
      stash.add(CmsContent(id: 0, generation: 1), TestComponent(value: 0));
      expect(stash.size, 1);
    });

    test('Stash add() doing nothing if component of this type already attached to the content', () {
      final content = CmsContent(id: 0, generation: 1);
      final component1 = TestComponent(value: 1);
      final component2 = TestComponent(value: 2);

      stash.add(content, component1);
      stash.add(content, component2);

      expect(stash.get(content), component1);
    });

    test('Stash has() check returns true for content that has component in stash', () {
      final content = CmsContent(id: 0, generation: 1);
      stash.add(content, TestComponent(value: 0));
      expect(stash.has(content), true);
    });

    test('Stash has() check returns false for content that has no component in stash', () {
      final content = CmsContent(id: 0, generation: 1);
      expect(stash.has(content), false);
    });

    test('Stash get() throws exception when no component attached to content', () {
      final content = CmsContent(id: 0, generation: 1);
      expect(() => stash.get(content), throwsException);
    });

    test('Stash get() returns valid component', () {
      final content = CmsContent(id: 0, generation: 1);
      final component = TestComponent(value: 0);
      
      stash.add(content, component);

      expect(stash.get(content), component);
    });

    test('Stash remove() returns true when removing existing component', () {
      final content = CmsContent(id: 0, generation: 1);
      final component = TestComponent(value: 0);
      
      stash.add(content, component);

      expect(stash.remove(content), true);
    });

    test('Stash remove() returns true when removing non-existing component', () {
      final content = CmsContent(id: 0, generation: 1);

      expect(stash.remove(content), true);
    });

  });
}