import 'package:clinc_management_app/feature/diomain/entities/patient.dart';

abstract class IPatientRepo {
  const IPatientRepo();
  Future<List<Patient>> getAllPatient();
  Future<List<Patient>> getAllPatientsFliter({
    String? name,
    String? phoneNumber,
  });
  Future<void> addPatient(Patient patient);
  Future<void> updatePatient({
    String? name,
    int? age,
    String? gender,
    String? phoneNumber,
  });
  Future<void> deletePatient({required int id});
}
