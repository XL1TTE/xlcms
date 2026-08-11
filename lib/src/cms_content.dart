
import 'package:equatable/equatable.dart';

final class CmsContent extends Equatable{
  final int id;
  final int generation;
  
  const CmsContent({required this.id, required this.generation});

  @override
  List<Object?> get props => [id, generation];
} 