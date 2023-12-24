import 'package:clinc_management_app/core/resourses/usecase.dart';
import 'package:clinc_management_app/feature/diomain/entities/aplicator.dart';
import 'package:clinc_management_app/feature/diomain/repositories/aplicator_repo.dart';

class GetAllApplicatorsUsecase extends Usecase<List<Applicator>, void> {
  GetAllApplicatorsUsecase(this._applicatorRepo);
  final IApplicatorRepo _applicatorRepo;

  @override
  Future<List<Applicator>> call({void params}) async {
    return await _applicatorRepo.getAllAplicators();
  }
}

class GetApplicatorByIdUsecase extends Usecase<Applicator?, int?> {
  GetApplicatorByIdUsecase(this._applicatorRepo);
  final IApplicatorRepo _applicatorRepo;

  @override
  Future<Applicator?> call({int? params}) async {
    return await _applicatorRepo.getAplicatorById(id: params!);
  }
}

class AddApplicatorUsecase extends Usecase<void, Applicator?> {
  AddApplicatorUsecase(this._applicatorRepo);
  final IApplicatorRepo _applicatorRepo;

  @override
  Future<void> call({Applicator? params}) async {
    await _applicatorRepo.addAplicator(params!);
  }
}
