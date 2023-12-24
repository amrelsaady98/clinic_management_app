import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

class Applicator extends Equatable {
  @PrimaryKey(
    autoGenerate: true,
  )
  final int id;
  final String name;

  const Applicator({required this.id, required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
