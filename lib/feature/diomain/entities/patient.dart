import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

class Patient extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final int age;
  final String gender;
  final String? phoneNumber;
  @ignore
  final List<Object>? reservations;

  const Patient({
    this.id,
    required this.name,
    required this.age,
    required this.gender,
    this.phoneNumber,
    this.reservations,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        gender,
        phoneNumber,
        reservations,
      ];
}
