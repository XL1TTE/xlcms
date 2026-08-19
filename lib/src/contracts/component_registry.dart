
import 'package:xlcms/src/contracts/component.dart';

abstract interface class IComponentRegistry {
    int getIndex<TComponent extends CmsComponent>();
}