
import 'package:xlcms/src/cms_content.dart';

abstract interface class IStashManager {
  TComponent attach<TComponent>(CmsContent content);
  bool unattach<TComponent>(CmsContent content);
  TComponent get<TComponent>(CmsContent content);
  bool has<TComponent>(CmsContent content);
}