import 'package:clinc_management_app/feature/data/repos/applicator_repo.dart';
import 'package:clinc_management_app/feature/diomain/entities/entities.dart';
import 'package:clinc_management_app/feature/diomain/usecases/usercases.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/applicator/applicators_event.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/applicator/applicators_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicatorsBloc extends Bloc<ApplicatorsEvent, ApplicatorsState> {
  final ApplicatorRepo _applicatorRepo;
  ApplicatorsBloc(
      {required ApplicatorsState initialState,
      required ApplicatorRepo applicatorRepo})
      : _applicatorRepo = applicatorRepo,
        super(initialState) {
    on<ApplicatorsEvent>((event, emit) async {
      if (event is AddApplicatorEvent) {
        await addApplicator(event, emit);
      } else if (event is GetAllApplicatorsEvent) {
        await loadAllApplicators(event, emit);
      }
    });
  }

  Future<void> addApplicator(
      AddApplicatorEvent event, Emitter<ApplicatorsState> emit) async {
    emit(state.copWith(isTableLoading: true));
    await AddApplicatorUsecase(_applicatorRepo).call(
      params: Applicator(name: event.name),
    );
    emit(state.copWith(isTableLoading: false));
    await loadAllApplicators(event, emit);
  }

  Future<void> loadAllApplicators(
      ApplicatorsEvent event, Emitter<ApplicatorsState> emit) async {
    emit(state.copWith(isTableLoading: true));
    final data = await GetAllApplicatorsUsecase(_applicatorRepo).call();
    emit(state.copWith(
      applicators: data,
      isTableLoading: false,
    ));
  }
}
