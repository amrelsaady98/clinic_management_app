import 'package:clinc_management_app/feature/diomain/entities/scan_cataloge.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "scanCataloge", primaryKeys: ['id'])
class ScanCatalogeModel extends ScanCataloge {
  const ScanCatalogeModel({
    required super.id,
    required super.type,
    required super.area,
    super.subArea,
    super.price,
    super.estimatedTime,
  });

  factory ScanCatalogeModel.fromEnitity(ScanCataloge scanCataloge) {
    return ScanCatalogeModel(
      id: scanCataloge.id,
      type: scanCataloge.type,
      area: scanCataloge.area,
      subArea: scanCataloge.subArea,
      price: scanCataloge.price,
      estimatedTime: scanCataloge.estimatedTime,
    );
  }
}
