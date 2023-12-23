import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

enum ScanType {
  XRay,
  Ultarsound,
  CT,
  MRI,
}

class ScanCataloge extends Equatable {
  @PrimaryKey(
    autoGenerate: true,
  )
  final int id;
  final ScanType type;
  final String area;
  final String? subArea;
  final double? price;
  final int? estimatedTime;

  const ScanCataloge({
    required this.id,
    required this.type,
    required this.area,
    this.subArea,
    this.price,
    this.estimatedTime,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        type,
        area,
        subArea,
        price,
        estimatedTime,
      ];
}
