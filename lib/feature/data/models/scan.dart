import 'package:clinc_management_app/feature/diomain/entities/entities.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'scan', primaryKeys: ['id'])
class ScanModel extends Scan {
  const ScanModel({
    required super.id,
    required super.reservationId,
    required super.applicatorId,
    required super.scanCatalogeId,
    super.scanCataloge,
    super.applicator,
  });

  factory ScanModel.frromEntity({
    required int id,
    required int reservationId,
    required int applicatorId,
    required int scanCatalogeId,
    ScanCataloge? scanCataloge,
    Applicator? applicator,
  }) =>
      ScanModel(
        id: id,
        reservationId: reservationId,
        applicatorId: applicatorId,
        scanCatalogeId: scanCatalogeId,
        scanCataloge: scanCataloge,
        applicator: applicator,
      );
}
