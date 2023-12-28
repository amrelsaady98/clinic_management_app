import 'package:clinc_management_app/feature/diomain/entities/entities.dart';
import 'package:equatable/equatable.dart';

class ApplicatorsState extends Equatable {
  final List<Applicator>? applicators;
  final bool isTableLoading;
  final bool loadTable;
  const ApplicatorsState({
    this.applicators,
    required this.isTableLoading,
    required this.loadTable,
  });
  factory ApplicatorsState.initialState() =>
      const ApplicatorsState(isTableLoading: true, loadTable: false);
  ApplicatorsState copWith({
    List<Applicator>? applicators,
    bool? isTableLoading,
    bool? loadTable,
  }) {
    return ApplicatorsState(
      applicators: applicators ?? this.applicators,
      isTableLoading: isTableLoading ?? this.isTableLoading,
      loadTable: loadTable ?? this.loadTable,
    );
  }

  @override
  List<Object?> get props => [
        applicators,
        isTableLoading,
      ];
}
