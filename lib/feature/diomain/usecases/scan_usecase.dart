import 'package:clinc_management_app/core/resourses/usecase.dart';
import 'package:clinc_management_app/feature/diomain/entities/scan_cataloge.dart';
import 'package:clinc_management_app/feature/diomain/repositories/scan_repo.dart';

class GetAllScanCatalogeUsecase extends Usecase<List<ScanCataloge>, void> {
  GetAllScanCatalogeUsecase(this._scanRepo);
  final IScanRepo _scanRepo;

  @override
  Future<List<ScanCataloge>> call({void params}) async {
    return await _scanRepo.getAllScanCataloge();
  }
}

class GetScanCatalogebyIdUsecase extends Usecase<ScanCataloge?, int> {
  GetScanCatalogebyIdUsecase(this._scanRepo);
  final IScanRepo _scanRepo;

  @override
  Future<ScanCataloge?> call({int? params}) async {
    return await _scanRepo.getScanCatalogeById(id: params ?? 0);
  }
}

class AddScanCatalogeUsecase extends Usecase<void, ScanCataloge> {
  AddScanCatalogeUsecase(this._scanRepo);
  final IScanRepo _scanRepo;
  @override
  Future<void> call({ScanCataloge? params}) async {
    await _scanRepo.addScanCataloge(params!);
  }
}
