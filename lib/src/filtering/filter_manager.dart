import 'dart:async';
import 'dart:collection';
import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/cms_global_configuration.dart';
import 'package:xlcms/src/contracts/component.dart';
import 'package:xlcms/src/contracts/component_registry.dart';
import 'package:xlcms/src/contracts/filter_manager.dart';
import 'package:xlcms/src/filtering/filter.dart';
import 'package:xlcms/src/filtering/filter_key.dart';
import 'package:xlcms/src/structs/bit_mask.dart';


final class FilterManager implements IFilterManager {
  final IComponentRegistry _registry;
  final ICmsGlobalReadOnlyConfiguration _configuration;

  final Map<CmsContent, BitMask> _entityMasks = {};
  final LinkedHashMap<FilterKey, Filter> _cache = LinkedHashMap();

  final Set<CmsContent> _dirtyEntities = {};
  bool _isUpdateScheduled = false;

  FilterManager({
    required this._registry,
    required this._configuration
  });

  @override
  void registerContent(CmsContent entity) {
    _entityMasks[entity] = BitMask(_configuration.bitsLimit);
  }

  @override
  void unregisterContent(CmsContent entity) {
    _entityMasks.remove(entity);
    _markDirty(entity);
  }

  @override
  void onComponentAttached<TComponent extends CmsComponent>(CmsContent entity) {
    final mask = _entityMasks[entity];
    if (mask != null) {
      final index = _registry.getIndex<TComponent>();
      mask[index] = true;
      _markDirty(entity);
    }
  }

  @override
  void onComponentDetached<TComponent extends CmsComponent>(CmsContent entity) {
    final mask = _entityMasks[entity];
    if (mask != null) {
      final index = _registry.getIndex<TComponent>();
      mask[index] = false;
      _markDirty(entity);
    }
  }

  @override
  Set<CmsContent> getFilteredContent(BitMask all, BitMask none) {
    final key = FilterKey(all: all, none: none);

    if (_cache.containsKey(key)) {
      final filter = _cache.remove(key)!;
      _cache[key] = filter;
      return filter.entities;
    }

    final filter = Filter(all: all, none: none);

    _entityMasks.forEach((entity, mask) {
      if (mask.matches(all: all, none: none)) {
        filter.entities.add(entity);
      }
    });

    if (_cache.length >= _configuration.filterCacheSize) {
      _cache.remove(_cache.keys.first);
    }

    _cache[key] = filter;
    return filter.entities;
  }

  void _markDirty(CmsContent entity) {
    _dirtyEntities.add(entity);
    if (!_isUpdateScheduled) {
      _isUpdateScheduled = true;
      scheduleMicrotask(_applyChanges);
    }
  }

  void _applyChanges() {
    _isUpdateScheduled = false;

    for (final entity in _dirtyEntities) {
      final mask = _entityMasks[entity];
      final exists = mask != null;

      for (final filter in _cache.values) {
        if (exists) {
          final isMatch = mask.matches(all: filter.all, none: filter.none);
          if (isMatch) {
            filter.entities.add(entity);
          } else {
            filter.entities.remove(entity);
          }
        } else {
          filter.entities.remove(entity);
        }
      }
    }

    _dirtyEntities.clear();
  }
}
