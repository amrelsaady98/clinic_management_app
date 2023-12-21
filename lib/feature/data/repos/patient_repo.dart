import 'package:clinc_management_app/feature/data/models/patient_model.dart';
import 'package:clinc_management_app/feature/data/sources/local/DAOs/patients_dao.dart';
import 'package:clinc_management_app/feature/diomain/entities/patient.dart';
import 'package:clinc_management_app/feature/diomain/repositories/patient_repo.dart';

class PatientsRepo extends IPatientRepo {
  final PatientDao _patientDao;
  const PatientsRepo(this._patientDao);
  @override
  Future<void> addPatient(Patient patient) async {
    await _patientDao.insertPatient(PatientModel.fromEntity(patient));
  }

  @override
  Future<void> deletePatient({required int id}) async {
    _patientDao.deletePatient(id);
  }

  @override
  Future<List<Patient>> getAllPatient() async {
    List<PatientModel>? data = await _patientDao.getAllPatient();
    return data ?? <Patient>[];
  }

  @override
  Future<List<Patient>> getAllPatientsFliter({
    String? name,
    String? phoneNumber,
  }) async {
    List<PatientModel>? data = await _patientDao.getAllPatientsFilter(
      "%${name ?? ""}%",
      "%${phoneNumber ?? ""}%",
    );
    return data ?? <Patient>[];
  }

  @override
  Future<void> updatePatient(
      {String? name, int? age, String? gender, String? phoneNumber}) {
    throw UnimplementedError();
  }
}
