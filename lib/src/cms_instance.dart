import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/content_manager.dart';
import 'package:xlcms/src/contracts/content_manager.dart';

import 'contracts/cms_instance.dart';

final class CmsInstance implements ICmsInstance{
  
  final IContentManager _contentManager = ContentManager();

  @override
  CmsContent createContent() {
    return _contentManager.createContent();
  }

  @override
  bool deleteContent(CmsContent content) {
    return _contentManager.deleteContent(content);
  }

  @override
  bool exist(CmsContent content) {
    return _contentManager.exist(content);
  } 
}