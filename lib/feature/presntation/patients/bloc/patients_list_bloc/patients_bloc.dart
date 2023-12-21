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
      }
    });
  }

  Future<void> loadPatientData(
      PatientsEvent event, Emitter<PatientState> emit) async {
    List<Patient> data = await GetAllPatientsUsecase(_patientsRepo).call();
    emit(PatientDataLodingDoneState(patientsList: data));
  }

  Future<void> loadFilteredPatientData(
      GetFilteredPateinetsEvent event, Emitter<PatientState> emit) async {
    emit(PatientDataLoadingState().withParameters(
      name: state.nameFilterController.text,
      phoneNumber: state.phoneNumberFilterController.text,
    ));

    List<Patient> data = await GetAllPatientsFilterUsecase(_patientsRepo)(
        params: <String, dynamic>{
          "name": state.nameFilterController.text,
          "phone_number": state.phoneNumberFilterController.text
        });
    emit(PatientDataLodingDoneState(patientsList: data).withParameters(
      name: state.nameFilterController.text,
      phoneNumber: state.phoneNumberFilterController.text,
    ));
  }

  Future<void> addPateint(
      PatientsEvent event, Emitter<PatientState> emit) async {
    await _patientsRepo.addPatient(Patient(
      name: state.addPateintNameController.text,
      age: int.parse(state.addPateintAgeController.text),
      gender: state.genderGroubValue ?? "not defined",
      phoneNumber: state.addPateintPhoneNumberController.text,
    ));
    await loadPatientData(event, emit);
  }
}
