import 'package:clinc_management_app/feature/data/models/applicator_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class ApplicatorDao {
  @Query('SELECT * FROM applicators')
  Future<List<ApplicatorModel>?> getAllApplicators();

  @Query('SELECT * FROM applicators WHERE id = :id')
  Future<ApplicatorModel?> getApplicatorById(int id);

  @insert
  Future<void> insertApplicator(ApplicatorModel applicatorModel);

  @Query('DELETE FROM applicators WHERE id = :id')
  Future<void> deleteApplicator(int id);
}
