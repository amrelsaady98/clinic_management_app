import 'package:clinc_management_app/feature/diomain/entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

class Scan extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int reservationId;
  final int applicatorId;
  final int scanCatalogeId;
  @ignore
  final ScanCataloge? scanCataloge;
  @ignore
  final Applicator? applicator;

  const Scan({
    required this.id,
    required this.reservationId,
    required this.applicatorId,
    required this.scanCatalogeId,
    this.scanCataloge,
    this.applicator,
  });

  @override
  List<Object?> get props => [
        reservationId,
        applicatorId,
        scanCatalogeId,
        scanCataloge,
        applicator,
      ];
}
