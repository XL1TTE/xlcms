import 'package:test/test.dart';
import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/cms_instance.dart';
import 'package:xlcms/src/contracts/cms_instance.dart';

import 'fixture/test_components.dart';

void main() {
  group('CMS Instance type tests', () {
    
    late ICmsInstance cms;

    setUp(() {
      cms = CmsInstance();
    });

    test('CMS successfully creates a content', () {

      var content = cms.createContent();

      expect(cms.exist(content), true);
    });

    test('CMS successfully deletes a content', () {

      var content = cms.createContent();
      cms.deleteContent(content);

      expect(cms.exist(content), false);
    });

    test('Id is reused and old content treated as not existing', () {

      var content1 = cms.createContent();
      cms.deleteContent(content1);
      var content2 = cms.createContent();
      
      expect(cms.exist(content1), false);
      expect(cms.exist(content2), true);
    });

    test('Ids being reused after deletion of content', () {

      var content1 = cms.createContent();
      cms.deleteContent(content1);
      var content2 = cms.createContent();

      expect(content1.id, content2.id);
    });

    test('Can attach components to content', () {

      var content = cms.createContent();
      final attached = TestComponent(value: 21);
      cms.attachComponent(content, attached);
      final retrived = cms.getComponent<TestComponent>(content);

      expect(retrived, isA<TestComponent>());
      expect(retrived, same(attached));
    });

    test('Can detach components from content', () {

      var content = cms.createContent();
      final attached = TestComponent(value: 21);
      cms.attachComponent(content, attached);
      cms.detachComponent(content);

      expect(cms.hasComponent<TestComponent>(content), false);
    });

    test('CMS instance throws if you trying to attach component to entity created outside this instance', () {
      final instance1 = CmsInstance();
      final instance2 = CmsInstance();
      final content = instance2.createContent();

      expect(() => instance1.attachComponent(content, TestComponent(value: 1)), throwsArgumentError); 
    });

    test('CMS instance throws if you trying to detach component from entity created outside this instance', () {
      final instance1 = CmsInstance();
      final instance2 = CmsInstance();
      final content = instance2.createContent();

      expect(() => instance1.detachComponent(content), throwsArgumentError); 
    });
    
  });
}
