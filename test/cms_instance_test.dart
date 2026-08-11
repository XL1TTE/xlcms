import 'package:test/test.dart';
import 'package:xlcms/src/cms_instance.dart';
import 'package:xlcms/src/contracts/cms_instance.dart';

void main() {
  group('CMS Instance type tests', () {
    
    late ICmsInstance cms;

    setUp(() {
      cms = CmsInstance();
    });

    test('CMS successfully creates a content.', () {

      var content = cms.createContent();

      expect(cms.exist(content), true);
    });

    test('CMS successfully deletes a content.', () {

      var content = cms.createContent();
      cms.deleteContent(content);

      expect(cms.exist(content), false);
    });

    test('Id is reused and old content treated as not existing.', () {

      var content1 = cms.createContent();
      cms.deleteContent(content1);
      var content2 = cms.createContent();
      
      expect(cms.exist(content1), false);
      expect(cms.exist(content2), true);
    });

    test('Ids being reused after deletion of content.', () {

      var content1 = cms.createContent();
      cms.deleteContent(content1);
      var content2 = cms.createContent();

      expect(content1.id, content2.id);
    });
    
  });
}
