import 'package:equatable/equatable.dart';

abstract class ApplicatorsEvent extends Equatable {}

class GetAllApplicatorsEvent extends ApplicatorsEvent {
  @override
  List<Object?> get props => [];
}

class AddApplicatorEvent extends ApplicatorsEvent {
  final String name;

  AddApplicatorEvent({
    required this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}
