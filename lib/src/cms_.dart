
import 'package:xlcms/src/cms_global_configuration.dart';
import 'package:xlcms/src/cms_instance.dart';
import 'package:xlcms/src/component_registry.dart';
import 'package:xlcms/src/contracts/component_registry.dart';

final class CMS {

  final CmsGlobalConfiguration _config = CmsGlobalConfiguration();
  ICmsGlobalReadOnlyConfiguration get config => _config;   

  late final IComponentRegistry _componentRegistry;
  IComponentRegistry get componentRegistry => _componentRegistry; 

  CMS(void Function(CmsGlobalConfiguration) configure){
    configure(_config);

    final componentRegistryFactory = _config.componentRegistryFactory ?? (config) => ComponentRegistry(config.bitsLimit);
    _componentRegistry = componentRegistryFactory(config);
  }

  CmsInstance create() => CmsInstance(configuration: config, componentRegistry: _componentRegistry);     
}


