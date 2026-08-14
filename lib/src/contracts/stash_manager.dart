
import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/contracts/component.dart';

abstract interface class IStashManager {
  TComponent attach<TComponent extends CmsComponent>(CmsContent content, TComponent value);
  bool detach<TComponent extends CmsComponent>(CmsContent content);
  TComponent get<TComponent extends CmsComponent>(CmsContent content);
  bool has<TComponent extends CmsComponent>(CmsContent content);
}