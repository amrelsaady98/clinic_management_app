import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

class Applicator extends Equatable {
  @PrimaryKey(
    autoGenerate: true,
  )
  final int? id;
  final String name;

  const Applicator({this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
