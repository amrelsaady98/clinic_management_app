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
  final String? nameFilter;
  final String? ageFilter;
  final String? phoneNumberFilter;
  const GetFilteredPateinetsEvent(
      {this.nameFilter, this.ageFilter, this.phoneNumberFilter});

  @override
  List<Object?> get props => [];
}

class NewPatientFieldUpdate extends PatientsEvent {
  final String? name, age, phoneNumber, gender;

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
  const AddPatientEvent({
    this.patientName,
    this.patientAge,
    this.patientGender,
    this.patientPhoneNumber,
  });

  final String? patientName, patientGender, patientPhoneNumber, patientAge;

  @override
  List<Object?> get props => [];
}

class ViewAddPatientSection extends PatientsEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class HideAddPatientSection extends PatientsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
