import 'package:xlcms/src/contracts/component.dart';

final class TestComponent implements CmsComponent{
  const TestComponent({required this.value});
  final int value;
}
final class SecondTestComponent implements CmsComponent{}
final class ThirdTestComponent implements CmsComponent{}