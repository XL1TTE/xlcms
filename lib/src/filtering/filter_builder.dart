import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/contracts/component.dart';
import 'package:xlcms/src/contracts/component_registry.dart';
import 'package:xlcms/src/structs/bit_mask.dart';

final class FilterBuilder {
  final IComponentRegistry _registry;
  final BitMask _all;
  final BitMask _none;
  final Set<CmsContent> Function(BitMask all, BitMask none) _collector;

  FilterBuilder({
    required this._registry,
    required int bitsLimit,
    required this._collector,
  }) : _all = BitMask(bitsLimit), _none = BitMask(bitsLimit);

  FilterBuilder and<TComponent extends CmsComponent>() {
    final index = _registry.getIndex<TComponent>();
    _all[index] = true;
    return this;
  }

  FilterBuilder no<TComponent extends CmsComponent>() {
    final index = _registry.getIndex<TComponent>();
    _none[index] = true;
    return this;
  }

  Set<CmsContent> collect() {
    return _collector(_all, _none);
  }
}
