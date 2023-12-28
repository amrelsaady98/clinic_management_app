import 'package:clinc_management_app/feature/data/models/applicator_model.dart';
import 'package:clinc_management_app/feature/data/sources/local/DAOs/applicators_dao.dart';
import 'package:clinc_management_app/feature/diomain/entities/entities.dart';
import 'package:clinc_management_app/feature/diomain/repositories/aplicator_repo.dart';

class ApplicatorRepo extends IApplicatorRepo {
  const ApplicatorRepo(this._applicatorDao);

  final ApplicatorDao _applicatorDao;

  @override
  Future<void> addAplicator(Applicator aplicator) async {
    await _applicatorDao
        .insertApplicator(ApplicatorModel.fromEntity(name: aplicator.name));
  }

  @override
  Future<void> deleteApplicator({required int id}) async {
    await _applicatorDao.deleteApplicator(id);
  }

  @override
  Future<List<Applicator>> getAllAplicators() async {
    return await _applicatorDao.getAllApplicators() ?? <Applicator>[];
  }

  @override
  Future<Applicator?> getAplicatorById({required int id}) async {
    return await _applicatorDao.getApplicatorById(id);
  }
}
