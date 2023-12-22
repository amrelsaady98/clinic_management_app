import 'package:clinc_management_app/feature/data/models/patient_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class PatientDao {
  @insert
  Future<void> insertPatient(PatientModel patient);
  @Query('DELETE FROM patients WHERE id = :id')
  Future<void> deletePatient(int id);

  @Query('SELECT * FROM patients WHERE id = :id')
  Future<PatientModel?> getPatientById(int id);

  @Query('SELECT * FROM  patients')
  Future<List<PatientModel>?> getAllPatient();

  @Query(
      'SELECT * FROM patients WHERE name LIKE :name AND (phoneNumber LIKE :phoneNumber OR phoneNumber  ISNULL) ORDER BY phoneNumber DESC, id ASC')
  Future<List<PatientModel>?> getAllPatientsFilter(
    String name,
    String phoneNumber,
  );
}
