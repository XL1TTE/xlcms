import 'package:xlcms/src/contracts/component.dart';
import 'package:xlcms/src/cms_instance.dart';
import 'package:xlcms/src/cms_.dart';

final class TestComponent implements CmsComponent{
  const TestComponent({required this.value});
  final int value;
}
final class SecondTestComponent implements CmsComponent{}
final class ThirdTestComponent implements CmsComponent{}

abstract final class TestCMS {

  static final CMS cms = CMS((config) {
  });

  static CmsInstance createDefaultInstance() {
    return cms.create();
  }
}