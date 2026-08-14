import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/content_manager.dart';
import 'package:xlcms/src/contracts/component.dart';
import 'package:xlcms/src/contracts/content_manager.dart';
import 'package:xlcms/src/contracts/stash_manager.dart';
import 'package:xlcms/src/stash_manager.dart';

import 'contracts/cms_instance.dart';

final class CmsInstance implements ICmsInstance{
  
  final IContentManager _contentManager = ContentManager();
  final IStashManager _stashManager = StashManager();

  @override
  CmsContent createContent() {
    return _contentManager.createContent();
  }

  @override
  bool deleteContent(CmsContent content) {
    return _contentManager.deleteContent(content);
  }

  @override
  bool exist(CmsContent content) {
    return _contentManager.exist(content);
  }

  @override
  TComponent attachComponent<TComponent extends CmsComponent>(CmsContent content, TComponent value) {
    if(_contentManager.exist(content) == false){
      throw ArgumentError.value(content, "Content not exist", "Unable to attach component to ${content.toString()}, because content not exist on this CMS instance.");
    }
    return _stashManager.attach(content, value);
  }

  @override
  bool detachComponent<TComponent extends CmsComponent>(CmsContent content) {
    if(_contentManager.exist(content) == false){
      throw ArgumentError.value(content, "Content not exist", "Unable to detach component from ${content.toString()}, because content not exist on this CMS instance.");
    }
    return _stashManager.detach(content);
  }

  @override
  bool hasComponent<TComponent extends CmsComponent>(CmsContent content) {
    return _stashManager.has(content);
  }

  @override
  TComponent getComponent<TComponent extends CmsComponent>(CmsContent content) {
    return _stashManager.get(content);
  }

}