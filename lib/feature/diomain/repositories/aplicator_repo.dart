import 'package:clinc_management_app/feature/diomain/entities/aplicator.dart';

abstract class IApplicatorRepo {
  const IApplicatorRepo();
  Future<List<Applicator>> getAllAplicators();
  Future<Applicator?> getAplicatorById({required int id});
  Future<void> addAplicator(Applicator aplicator);
  Future<void> deleteApplicator({required int id});
}
