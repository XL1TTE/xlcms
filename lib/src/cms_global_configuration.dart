import 'package:xlcms/src/contracts/component_registry.dart';

abstract interface class ICmsGlobalReadOnlyConfiguration{
    int get bitsLimit;
    int get filterCacheSize;
}

typedef RegistryFactory = IComponentRegistry Function(ICmsGlobalReadOnlyConfiguration);

final class CmsGlobalConfiguration implements ICmsGlobalReadOnlyConfiguration
{
  int _bitsLimit = 128;
  @override int get bitsLimit => _bitsLimit;

  int _filterCacheSize = 32;
  @override int get filterCacheSize => _filterCacheSize;

  RegistryFactory? componentRegistryFactory;

  CmsGlobalConfiguration withBitsLimit(int limit) {
    if(limit <= 0 || limit >= (1 << 10)) throw ArgumentError.value(limit, "Must be in range [0, 2^10]");

    _bitsLimit = limit;
    return this;
  }

  CmsGlobalConfiguration withFilterCacheLimit(int limit) {
    if(limit < (1 << 5) || limit > (1 << 12)) throw ArgumentError.value(limit, "Must be in range [2^5, 2^12]");

    _filterCacheSize = limit;
    return this;
  }

}

