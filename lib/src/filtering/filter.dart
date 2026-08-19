import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/structs/bit_mask.dart';

final class Filter {
  final BitMask all;
  final BitMask none;
  final Set<CmsContent> entities = {};

  Filter({required this.all, required this.none});
}
