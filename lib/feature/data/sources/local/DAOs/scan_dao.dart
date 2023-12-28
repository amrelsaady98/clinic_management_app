import 'package:clinc_management_app/feature/data/models/scan.dart';
import 'package:clinc_management_app/feature/data/models/scan_cataoge.dart';
import 'package:floor/floor.dart';

@dao
abstract class ScanDao {
  @insert
  Future<void> insertScan(ScanModel scan);
  @Query('SELECT * FROM scan WHERE reservationId = :reservationId')
  Future<List<ScanModel>?> getAllScanByResevation(int reservationId);
  @Query('SELECT * FROM scan WHERE applicatorId = :applicatorId')
  Future<List<ScanModel>?> getAllScanByApplicator(int applicatorId);
}
