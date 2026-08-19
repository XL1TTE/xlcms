
import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/contracts/component.dart';
import 'package:xlcms/src/contracts/stash_manager.dart';
import 'package:xlcms/src/contracts/stash_registry.dart';
import 'package:xlcms/src/stash/stash_registry.dart';

final class StashManager implements IStashManager{

  final IStashRegistry _stashRegistry = StashRegistry();

  @override
  TComponent attach<TComponent extends CmsComponent>(CmsContent content, TComponent value) {
    return _stashRegistry.getStash<TComponent>().add(content, value);
  }

  @override
  bool detach<TComponent extends CmsComponent>(CmsContent content) {
    return _stashRegistry.getStash<TComponent>().remove(content);
  }

  @override
  TComponent get<TComponent extends CmsComponent>(CmsContent content) {
    return _stashRegistry.getStash<TComponent>().get(content);
  }

  @override
  bool has<TComponent extends CmsComponent>(CmsContent content) {
    return _stashRegistry.getStash<TComponent>().has(content);
  }

  @override
  void clear(CmsContent content) {
    for(final stash in _stashRegistry.stashes){
      stash.remove(content);
    }
  }

}