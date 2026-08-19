

import 'package:xlcms/src/contracts/component.dart';
import 'package:xlcms/src/contracts/stash.dart';
import 'package:xlcms/src/stash/stash.dart';

abstract interface class IStashRegistry {
    int get stashCount;
    Iterable<IStash> get stashes;
    Stash<TComponent> getStash<TComponent extends CmsComponent>();
}