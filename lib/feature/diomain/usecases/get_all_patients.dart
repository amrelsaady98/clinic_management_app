import 'package:clinc_management_app/core/resourses/usecase.dart';
import 'package:clinc_management_app/feature/diomain/entities/patient.dart';
import 'package:clinc_management_app/feature/diomain/repositories/patient_repo.dart';

class GetAllPatientsFilterUsecase
    extends Usecase<List<Patient>, Map<String, dynamic>> {
  final IPatientRepo _patientRepo;
  GetAllPatientsFilterUsecase(this._patientRepo);

  @override
  Future<List<Patient>> call({Map<String, dynamic>? params}) async {
    return await _patientRepo.getAllPatientsFliter(
      name: params?['name'],
      phoneNumber: params?['phone_number'],
    );
  }
}

class GetAllPatientsUsecase extends Usecase<List<Patient>?, void> {
  final IPatientRepo _patientRepo;
  GetAllPatientsUsecase(this._patientRepo);
  @override
  Future<List<Patient>> call({void params}) async {
    return await _patientRepo.getAllPatient();
  }
}

class AddPatientUsecase extends Usecase<void, Patient> {
  final IPatientRepo _patientRepo;
  AddPatientUsecase(this._patientRepo);
  @override
  Future<void> call({Patient? params}) async {
    return await _patientRepo.addPatient(params!);
  }
}
