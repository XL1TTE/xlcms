import 'package:equatable/equatable.dart';
import 'package:xlcms/src/structs/bit_mask.dart';

final class FilterKey extends Equatable {
  final BitMask all;
  final BitMask none;

  const FilterKey({required this.all, required this.none});

  @override
  List<Object?> get props => [all, none];
}
