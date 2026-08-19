import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/contracts/component.dart';
import 'package:xlcms/src/structs/bit_mask.dart';

abstract interface class IFilterManager {
  void registerContent(CmsContent content);
  void unregisterContent(CmsContent content);
  void onComponentAttached<TComponent extends CmsComponent>(CmsContent content);
  void onComponentDetached<TComponent extends CmsComponent>(CmsContent content);
  Set<CmsContent> getFilteredContent(BitMask all, BitMask none);
}
