import 'package:clinc_management_app/feature/diomain/entities/entities.dart';
import 'package:equatable/equatable.dart';

abstract class ScanCatalogEvent extends Equatable {}

class GetAllScanCatalogEvent extends ScanCatalogEvent {
  @override
  List<Object?> get props => [];
}

class AddScanCatalogEvent extends ScanCatalogEvent {
  final ScanType type;
  final String area;
  final String? subArea;
  final double? price;
  final int? estimatedTime;

  AddScanCatalogEvent({
    required this.type,
    required this.area,
    required this.subArea,
    required this.price,
    required this.estimatedTime,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        type,
        area,
        subArea,
        price,
        estimatedTime,
      ];
}
