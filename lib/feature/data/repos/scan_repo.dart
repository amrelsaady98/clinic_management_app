import 'package:clinc_management_app/feature/data/models/scan_cataoge.dart';
import 'package:clinc_management_app/feature/data/sources/local/DAOs/scan_dao.dart';
import 'package:clinc_management_app/feature/diomain/entities/scan.dart';
import 'package:clinc_management_app/feature/diomain/entities/scan_cataloge.dart';
import 'package:clinc_management_app/feature/diomain/repositories/scan_repo.dart';

class ScanRepo extends IScanRepo {
  final ScanDao _scanDao;

  ScanRepo({required ScanDao scanDao}) : _scanDao = scanDao;
  @override
  Future<void> addScanCataloge(ScanCataloge scanCataloge) async {
    await _scanDao
        .insertScanCataloge(ScanCatalogeModel.fromEnitity(scanCataloge));
  }

  @override
  Future<void> deleteScanCataloge(ScanCataloge scanCataloge) async {
    await _scanDao
        .deleteScanCataloge(ScanCatalogeModel.fromEnitity(scanCataloge));
  }

  @override
  Future<List<ScanCataloge>> getAllScanCataloge() async {
    return await _scanDao.getAllScanCataloge() ?? <ScanCataloge>[];
  }

  @override
  Future<ScanCataloge?> getScanCatalogeById({required int id}) async {
    return await _scanDao.getScanCatalogeById(id);
  }

  @override
  // TODO: implement updateScanCataloge
  Future<void> updateScanCataloge({
    required int id,
    ScanType? type,
    String? area,
    String? subArea,
    double? price,
    int? estimatedTime,
  }) async {
    ScanCataloge? scanCataloge = await getScanCatalogeById(id: id);
    if (scanCataloge != null) {
      _scanDao.updateScanCataloge(ScanCatalogeModel(
        id: id,
        type: type ?? scanCataloge.type,
        area: area ?? scanCataloge.area,
        subArea: subArea ?? scanCataloge.subArea,
        price: price ?? scanCataloge.price,
        estimatedTime: estimatedTime ?? scanCataloge.estimatedTime,
      ));
    }
  }

  @override
  Future<void> addScan({required Scan scan}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Scan>?> getScansByApplicatorId({required int applicatorId}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Scan>?> getScansByReservation({required int reservationId}) {
    throw UnimplementedError();
  }
}
