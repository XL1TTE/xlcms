import 'package:test/test.dart';
import 'package:xlcms/src/contracts/stash_registry.dart';
import 'package:xlcms/src/stash/stash.dart';
import 'package:xlcms/src/stash/stash_registry.dart';

import 'fixture/test_components.dart';

void main() {
  
  group("StashRegistry tests", () {

    late IStashRegistry registry;

    setUp(() {
      registry = StashRegistry();
    });

    test("Registry creates new stash if no stashes for provided type was registered before", () {
      final stash = registry.getStash<TestComponent>();

      expect(registry.stashCount, 1);
      expect(stash, isA<Stash<TestComponent>>());
    });

    test("Registry returns same stash if it registered before", () {
      final first = registry.getStash<TestComponent>();
      final second = registry.getStash<TestComponent>();

      expect(first, same(second));
    });

    test("Registry have expected size equals the count of get calls for each unique CmsComponent type", () {
      registry.getStash<TestComponent>();
      registry.getStash<SecondTestComponent>();
      registry.getStash<ThirdTestComponent>();

      expect(registry.stashCount, 3);
    });
  });
}