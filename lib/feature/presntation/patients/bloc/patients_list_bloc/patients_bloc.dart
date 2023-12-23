import 'dart:async';

import 'package:clinc_management_app/feature/data/repos/patient_repo.dart';
import 'package:clinc_management_app/feature/diomain/entities/patient.dart';
import 'package:clinc_management_app/feature/diomain/usecases/get_all_patients.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patient_state.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patients_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientBloc extends Bloc<PatientsEvent, PatientState> {
  final PatientsRepo _patientsRepo;

  PatientBloc(
      {required PatientsRepo patientsRepo, required PatientState initialState})
      : _patientsRepo = patientsRepo,
        super(initialState) {
    on<PatientsEvent>((event, emit) async {
      if (event is GetAllPatientsEvent) {
        await loadPatientData(event, emit);
      } else if (event is AddPatientEvent) {
        await addPateint(event, emit);
      } else if (event is GetFilteredPateinetsEvent) {
        await loadFilteredPatientData(event, emit);
      } else if (event is ViewAddPatientSection) {
        await viewAddPatientSection(event, emit);
      } else if (event is HideAddPatientSection) {
        await hideAddPatientSection(event, emit);
      }
    });
  }

  Future<void> loadPatientData(
      PatientsEvent event, Emitter<PatientState> emit) async {
    emit(state.copyWith(isTableLoading: true));
    List<Patient> data = await GetAllPatientsUsecase(_patientsRepo).call();
    emit(state.copyWith(isTableLoading: false, patientsList: data));
  }

  Future<void> loadFilteredPatientData(
      GetFilteredPateinetsEvent event, Emitter<PatientState> emit) async {
    emit(state.copyWith(
      nameFilter: event.nameFilter,
      ageFilter: event.ageFilter != null ? int.parse(event.ageFilter!) : null,
      phoneNumberFilter: event.phoneNumberFilter,
    ));
    if ((state.nameFilter == null || state.nameFilter == "") &&
        (state.phoneNumberFilter == null || state.phoneNumberFilter == "")) {
      await loadPatientData(event, emit);
      return;
    }
    List<Patient> data = await GetAllPatientsFilterUsecase(_patientsRepo)(
        params: <String, dynamic>{
          "name": state.nameFilter,
          "phone_number": state.phoneNumberFilter
        });
    emit(state.copyWith(patientsList: data, isTableLoading: false));
  }

  Future<void> addPateint(
      AddPatientEvent event, Emitter<PatientState> emit) async {
    emit(state.copyWith(isAddPatientLoading: true));
    await _patientsRepo.addPatient(Patient(
      name: event.patientName!,
      age: int.parse(event.patientAge!),
      gender: event.patientGender!,
      phoneNumber: event.patientPhoneNumber!,
    ));
    emit(state.copyWith(
      isPatientAdded: true,
      isAddPatientLoading: false,
    ));
    await loadPatientData(event, emit);
  }

  viewAddPatientSection(
      ViewAddPatientSection event, Emitter<PatientState> emit) {
    emit(state.copyWith(addPatientVisible: true));
  }

  hideAddPatientSection(
      HideAddPatientSection event, Emitter<PatientState> emit) {
    emit(state.copyWith(addPatientVisible: false));
  }
}
