import 'package:clinc_management_app/feature/data/models/scan_cataoge.dart';
import 'package:clinc_management_app/feature/diomain/entities/scan_cataloge.dart';
import 'package:floor/floor.dart';

@dao
abstract class ScanDao {
  @insert
  Future<void> insertScanCataloge(ScanCatalogeModel scanCataloge);

  @delete
  Future<void> deleteScanCataloge(ScanCatalogeModel scanCataloge);
  @update
  Future<void> updateScanCataloge(ScanCatalogeModel scanCatalogeModel);

  @Query('SELECT * FROM scan_cataloge')
  Future<List<ScanCatalogeModel>?> getAllScanCataloge();
  @Query('SELECT * FROM scan_cataloge WHERE id = :id')
  Future<ScanCatalogeModel?> getScanCatalogeById(int id);
}
