import 'package:clinc_management_app/feature/diomain/entities/scan.dart';
import 'package:floor/floor.dart';

@dao
abstract class ScanDAO {
  @insert
  Future<void> insertScanCataloge(ScanCataloge scanCataloge);
}
