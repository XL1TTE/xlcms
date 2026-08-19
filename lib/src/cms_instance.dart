import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/cms_global_configuration.dart';
import 'package:xlcms/src/content_manager.dart';
import 'package:xlcms/src/contracts/component.dart';
import 'package:xlcms/src/contracts/component_registry.dart';
import 'package:xlcms/src/contracts/content_manager.dart';
import 'package:xlcms/src/contracts/filter_manager.dart';
import 'package:xlcms/src/contracts/stash_manager.dart';
import 'package:xlcms/src/filtering/filter_builder.dart';
import 'package:xlcms/src/filtering/filter_manager.dart';
import 'package:xlcms/src/stash/stash_manager.dart';

import 'contracts/cms_instance.dart';

final class CmsInstance implements ICmsInstance{

  CmsInstance({required this._configuration, required this._componentRegistry}){
    _filterManager = FilterManager(registry: _componentRegistry, configuration: _configuration);
  }

  final ICmsGlobalReadOnlyConfiguration _configuration;
  final IComponentRegistry _componentRegistry;

  late final IFilterManager  _filterManager;
  final      IContentManager _contentManager = ContentManager();
  final      IStashManager   _stashManager   = StashManager();

  @override
  CmsContent createContent() {
    final content = _contentManager.createContent();
    _filterManager.registerContent(content);
    return content;
  }

  @override
  bool deleteContent(CmsContent content) {
    if(_contentManager.deleteContent(content) == false) return false;

    _filterManager.unregisterContent(content);
    _stashManager.clear(content);
    return true;
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
    final component = _stashManager.attach<TComponent>(content, value);
    _filterManager.onComponentAttached<TComponent>(content);
    return component;
  }

  @override
  bool detachComponent<TComponent extends CmsComponent>(CmsContent content) {
    if(_contentManager.exist(content) == false){
      throw ArgumentError.value(content, "Content not exist", "Unable to detach component from ${content.toString()}, because content not exist on this CMS instance.");
    }
    final removed = _stashManager.detach<TComponent>(content);
    if (removed) {
      _filterManager.onComponentDetached<TComponent>(content);
    }
    return removed;
  }

  @override
  bool hasComponent<TComponent extends CmsComponent>(CmsContent content) {
    return _stashManager.has<TComponent>(content);
  }

  @override
  TComponent getComponent<TComponent extends CmsComponent>(CmsContent content) {
    return _stashManager.get<TComponent>(content);
  }

  @override
  FilterBuilder filter() {
    return FilterBuilder(
      registry: _componentRegistry,
      bitsLimit: _configuration.bitsLimit,
      collector: (all, none) => _filterManager.getFilteredContent(all, none),
    );
  }

}