import 'package:test/test.dart';
import 'package:xlcms/src/cms_instance.dart';
import 'package:xlcms/src/contracts/cms_instance.dart';

void main() {
  group('CMS Instance type tests', () {
    
    late ICmsInstance cmsInstance;

    setUp(() {
      cmsInstance = CmsInstance();
    });

    test('CMS successfully creates a content.', () {

      var content = cmsInstance.createContent();

      expect(cmsInstance.exist(content), true);
    });

    test('CMS successfully deletes a content.', () {

      var content = cmsInstance.createContent();
      cmsInstance.deleteContent(content);

      expect(cmsInstance.exist(content), false);
    });

    test('Id is reused and old content treated as not existing.', () {

      var content1 = cmsInstance.createContent();
      cmsInstance.deleteContent(content1);
      var content2 = cmsInstance.createContent();
      
      expect(cmsInstance.exist(content1), false);
      expect(cmsInstance.exist(content2), true);
    });

    test('Ids being reused after deletion of conent.', () {

      var content1 = cmsInstance.createContent();
      cmsInstance.deleteContent(content1);
      var content2 = cmsInstance.createContent();

      expect(content1.id, content2.id);
    });
    
  });
}
