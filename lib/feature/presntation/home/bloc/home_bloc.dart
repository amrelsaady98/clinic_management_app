import 'package:clinc_management_app/feature/presntation/home/bloc/home_event.dart';
import 'package:clinc_management_app/feature/presntation/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomePageEvent, HomeState> {
  HomeBloc({required HomeState initialState}) : super(initialState) {
    on<NavigationItemClicked>(
        (event, emit) => emit(HomeState(event.selectedPage)));
  }
}
