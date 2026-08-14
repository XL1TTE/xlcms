

import 'package:xlcms/src/contracts/component.dart';
import 'package:xlcms/src/stash.dart';

abstract interface class IStashRegistry {
    int get stashCount;
    Stash<TComponent> getStash<TComponent extends CmsComponent>();
}