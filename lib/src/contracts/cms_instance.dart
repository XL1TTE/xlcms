import 'package:xlcms/src/cms_content.dart';

abstract interface class ICmsInstance {
    CmsContent createContent();
    bool deleteContent(CmsContent content);
    bool exist(CmsContent content);
}