
import 'package:xlcms/src/contracts/component.dart';
import 'package:xlcms/src/contracts/component_registry.dart';

final class ComponentRegistryUnitialized implements IComponentRegistry{
  @override
  int getIndex<TComponent extends CmsComponent>() {
    throw StateError("Component registry is not configured correctly!");
  }
}

final class ComponentRegistry implements IComponentRegistry {
  final Map<Type, int> _indices = {};
  final int _bitsCapacity;
  int _counter = 0;

  ComponentRegistry(int maxBits) : _bitsCapacity = maxBits;

  @override
  int getIndex<TComponent extends CmsComponent>() {

    var index = _indices[TComponent];

    if (index == null) {
      if (_counter >= _bitsCapacity) {
        throw StateError(
          'Maximum number of component types ($_bitsCapacity) reached.'
        );
      }
      index = _counter++;
      _indices[TComponent] = index;
    }

    return index;
  }
}