import 'package:equatable/equatable.dart';

abstract class PatientsEvent extends Equatable {
  const PatientsEvent();
}

class GetAllPatientsEvent extends PatientsEvent {
  const GetAllPatientsEvent();
  @override
  List<Object?> get props => [];
}

class GetFilteredPateinetsEvent extends PatientsEvent {
  const GetFilteredPateinetsEvent();

  @override
  List<Object?> get props => [];
}

class NewPatientFieldUpdate extends PatientsEvent {
  final String? name, phoneNumber, gender;
  final int? age;

  const NewPatientFieldUpdate({
    this.name,
    this.phoneNumber,
    this.gender,
    this.age,
  });

  @override
  List<Object?> get props => [name, phoneNumber, gender, age];
}

class AddPatientEvent extends PatientsEvent {
  @override
  List<Object?> get props => [];
}
