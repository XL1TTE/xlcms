
import 'package:xlcms/src/contracts/component.dart';
import 'package:xlcms/src/contracts/stash.dart';
import 'package:xlcms/src/contracts/stash_registry.dart';
import 'package:xlcms/src/stash/stash.dart';

final class StashRegistry implements IStashRegistry {
  final Map<Type, IStash> _registry = {};
  
  @override
  int get stashCount => _registry.length;

  @override
  Iterable<IStash> get stashes => _registry.values;

  @override
  Stash<TComponent> getStash<TComponent extends CmsComponent>() {
    return _registry.putIfAbsent(TComponent, () => Stash<TComponent>()) as Stash<TComponent>;    
  }
}