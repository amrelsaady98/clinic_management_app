import 'package:clinc_management_app/feature/diomain/entities/entities.dart';

abstract class IScanRepo {
  Future<List<ScanCataloge>> getAllScanCataloge();
  Future<ScanCataloge?> getScanCatalogeById({required int id});
  Future<void> addScanCataloge(ScanCataloge scanCataloge);
  Future<void> updateScanCataloge({
    required int id,
    ScanType? type,
    String? area,
    String? subArea,
    double? price,
    int? estimatedTime,
  });
  Future<void> deleteScanCataloge(ScanCataloge scanCataloge);

  Future<void> addScan({required Scan scan});
  Future<List<Scan>?> getScansByReservation({required int reservationId});
  Future<List<Scan>?> getScansByApplicatorId({required int applicatorId});
}
