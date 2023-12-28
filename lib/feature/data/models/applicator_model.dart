import 'package:clinc_management_app/feature/diomain/entities/aplicator.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'applicators', primaryKeys: ['id'])
class ApplicatorModel extends Applicator {
  const ApplicatorModel({required super.id, required super.name});
  factory ApplicatorModel.fromEntity({int? id, required name}) =>
      ApplicatorModel(id: id, name: name);
}
