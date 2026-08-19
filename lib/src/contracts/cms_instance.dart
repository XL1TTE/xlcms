import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/contracts/component.dart';
import 'package:xlcms/src/filtering/filter_builder.dart';

abstract interface class ICmsInstance {

    CmsContent createContent();
    bool       deleteContent(CmsContent content);
    bool       exist(CmsContent content);

    TComponent attachComponent<TComponent extends CmsComponent>(CmsContent content, TComponent value);
    bool       detachComponent<TComponent extends CmsComponent>(CmsContent content);
    TComponent getComponent<TComponent extends CmsComponent>(CmsContent content);
    bool       hasComponent<TComponent extends CmsComponent>(CmsContent content);

    FilterBuilder filter();
}