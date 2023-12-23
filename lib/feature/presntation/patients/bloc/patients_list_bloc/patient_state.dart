import 'package:clinc_management_app/feature/diomain/entities/patient.dart';
import 'package:equatable/equatable.dart';

class PatientState extends Equatable {
  final List<Patient>? patientsList;

  final String? nameFilter;
  final int? ageFilter;
  final String? phoneNumberFilter;

  final bool isTableLoading;
  final bool isAddPatientLoading;
  final bool isPatientAdded;
  final bool addPatientVisible;

  const PatientState({
    this.patientsList,
    this.nameFilter,
    this.ageFilter,
    this.phoneNumberFilter,
    this.isTableLoading = false,
    this.isAddPatientLoading = false,
    this.isPatientAdded = false,
    this.addPatientVisible = false,
  });

  PatientState copyWith(
      {List<Patient>? patientsList,
      String? nameFilter,
      int? ageFilter,
      String? phoneNumberFilter,
      String? newPatientName,
      String? newPatientAge,
      String? newPatientGender,
      String? newPatientPhoneNumber,
      bool? isTableLoading,
      bool? isAddPatientLoading,
      bool? isPatientAdded,
      bool? addPatientVisible}) {
    return PatientState(
      patientsList: patientsList ?? this.patientsList,
      nameFilter: nameFilter ?? this.nameFilter,
      ageFilter: ageFilter ?? this.ageFilter,
      phoneNumberFilter: phoneNumberFilter ?? this.phoneNumberFilter,
      isAddPatientLoading: isAddPatientLoading ?? this.isAddPatientLoading,
      isTableLoading: isTableLoading ?? this.isTableLoading,
      isPatientAdded: isPatientAdded ?? this.isPatientAdded,
      addPatientVisible: addPatientVisible ?? this.addPatientVisible,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        patientsList,
        nameFilter,
        ageFilter,
        phoneNumberFilter,
        isTableLoading,
        isAddPatientLoading,
        addPatientVisible,
      ];
}
