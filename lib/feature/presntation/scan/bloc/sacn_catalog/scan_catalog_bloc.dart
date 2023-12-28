import 'package:clinc_management_app/feature/data/repos/scan_repo.dart';
import 'package:clinc_management_app/feature/diomain/entities/entities.dart';
import 'package:clinc_management_app/feature/diomain/usecases/usercases.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_event.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanCatalogBloc extends Bloc<ScanCatalogEvent, ScanCatalogState> {
  final ScanRepo _scanRepo;
  ScanCatalogBloc(
      {required ScanCatalogState initialState, required ScanRepo scanRepo})
      : _scanRepo = scanRepo,
        super(initialState) {
    on<ScanCatalogEvent>((event, emit) async {
      if (event is AddScanCatalogEvent) {
        await addScanCatalog(event, emit);
      } else if (event is GetAllScanCatalogEvent) {
        await loadAllScanCatalog(event, emit);
      }
    });
  }

  Future<void> addScanCatalog(
      AddScanCatalogEvent event, Emitter<ScanCatalogState> emit) async {
    emit(state.copWith(isTableLoading: true));
    await AddScanCatalogeUsecase(_scanRepo).call(
      params: ScanCataloge(
        type: event.type,
        area: event.area,
        subArea: event.subArea,
        price: event.price,
        estimatedTime: event.estimatedTime,
      ),
    );
    await loadAllScanCatalog(event, emit);
  }

  Future<void> loadAllScanCatalog(
      ScanCatalogEvent event, Emitter<ScanCatalogState> emit) async {
    emit(state.copWith(isTableLoading: true));
    final data = await GetAllScanCatalogeUsecase(_scanRepo).call();
    emit(state.copWith(
      scanCatalogs: data,
      isTableLoading: false,
    ));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
