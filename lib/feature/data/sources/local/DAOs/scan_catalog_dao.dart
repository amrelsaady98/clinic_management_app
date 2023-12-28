import 'package:clinc_management_app/feature/data/models/models.dart';
import 'package:floor/floor.dart';

@dao
abstract class ScanCatalogeDao {
  @insert
  Future<void> insertScanCataloge(ScanCatalogeModel scanCataloge);

  @delete
  Future<void> deleteScanCataloge(ScanCatalogeModel scanCataloge);
  @update
  Future<void> updateScanCataloge(ScanCatalogeModel scanCatalogeModel);

  @Query('SELECT * FROM scanCataloge')
  Future<List<ScanCatalogeModel>?> getAllScanCataloge();
  @Query('SELECT * FROM scanCataloge WHERE id = :id')
  Future<ScanCatalogeModel?> getScanCatalogeById(int id);
}
