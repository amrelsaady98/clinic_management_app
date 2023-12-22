import 'package:clinc_management_app/feature/diomain/entities/patient.dart';
import 'package:equatable/equatable.dart';

class PatientState extends Equatable {
  final List<Patient>? patientsList;

  final String? nameFilter;
  final int? ageFilter;
  final String? phoneNumberFilter;

  final String? newPatientName;
  final String? newPatientAge;
  final String? newPatientGender;
  final String? newPatientPhoneNumber;

  final bool isTableLoading;
  final bool isAddPatientLoading;

  const PatientState({
    this.patientsList,
    this.nameFilter,
    this.ageFilter,
    this.newPatientName,
    this.newPatientAge,
    this.newPatientGender,
    this.newPatientPhoneNumber,
    this.phoneNumberFilter,
    this.isTableLoading = false,
    this.isAddPatientLoading = false,
  });

  PatientState copyWith({
    List<Patient>? patientsList,
    String? nameFilter,
    int? ageFilter,
    String? phoneNumberFilter,
    String? newPatientName,
    String? newPatientAge,
    String? newPatientGender,
    String? newPatientPhoneNumber,
    bool? isTableLoading,
    bool? isAddPatientLoading,
  }) {
    return PatientState(
      patientsList: patientsList ?? this.patientsList,
      nameFilter: nameFilter ?? this.nameFilter,
      ageFilter: ageFilter ?? this.ageFilter,
      phoneNumberFilter: phoneNumberFilter ?? this.phoneNumberFilter,
      newPatientName: newPatientName ?? this.newPatientName,
      newPatientAge: newPatientAge ?? this.newPatientAge,
      newPatientGender: newPatientGender ?? this.newPatientGender,
      newPatientPhoneNumber:
          newPatientPhoneNumber ?? this.newPatientPhoneNumber,
      isAddPatientLoading: isAddPatientLoading ?? this.isAddPatientLoading,
      isTableLoading: isTableLoading ?? this.isTableLoading,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        patientsList,
        nameFilter,
        ageFilter,
        newPatientName,
        newPatientAge,
        newPatientGender,
        newPatientPhoneNumber,
        phoneNumberFilter,
        isTableLoading,
        isAddPatientLoading,
      ];
}
