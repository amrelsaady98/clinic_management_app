import 'package:clinc_management_app/feature/diomain/entities/patient.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

abstract class PatientState extends Equatable {
  final List<Patient>? patientsList;

  final String? nameFilter;
  final int? ageFilter;
  final String? phoneNumberFilter;

  final bool? isTableLoading;

  final TextEditingController addPateintNameController =
      TextEditingController();
  final TextEditingController addPateintAgeController = TextEditingController();
  final TextEditingController addPateintGenderController =
      TextEditingController();
  final TextEditingController addPateintPhoneNumberController =
      TextEditingController();

  final TextEditingController nameFilterController = TextEditingController();
  final TextEditingController phoneNumberFilterController =
      TextEditingController();

  String? genderGroubValue;

  PatientState({
    this.patientsList,
    this.nameFilter,
    this.ageFilter,
    this.phoneNumberFilter,
    this.isTableLoading,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        patientsList,
        nameFilter,
        ageFilter,
        phoneNumberFilter,
        isTableLoading,
      ];
}

class PatientDataLoadingState extends PatientState {
  PatientDataLoadingState withParameters({
    String? name,
    String? phoneNumber,
  }) {
    phoneNumberFilterController.text = phoneNumber ?? "";
    nameFilterController.text = name ?? "";
    nameFilterController.selection.end;
    return this;
  }
}

class PatientDataLodingDoneState extends PatientState {
  PatientDataLodingDoneState({List<Patient>? patientsList})
      : super(patientsList: patientsList);
  PatientDataLodingDoneState withParameters({
    String? name,
    String? phoneNumber,
  }) {
    nameFilterController.selection =
        TextSelection.fromPosition(TextPosition(offset: name?.length ?? 0));
    phoneNumberFilterController.text = phoneNumber ?? "";
    nameFilterController.text = name ?? "";
    return this;
  }
}

class PatientAddedState extends PatientState {
  PatientAddedState({
    super.patientsList,
    super.nameFilter,
    super.ageFilter,
    super.phoneNumberFilter,
  });
}

class PatientAddLoading extends PatientState {
  PatientAddLoading({
    super.patientsList,
    super.nameFilter,
    super.ageFilter,
    super.phoneNumberFilter,
  });
}
