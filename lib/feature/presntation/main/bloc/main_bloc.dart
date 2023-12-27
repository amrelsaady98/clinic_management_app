import 'package:clinc_management_app/feature/presntation/main/bloc/main_event.dart';
import 'package:clinc_management_app/feature/presntation/main/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Main extends Bloc<MainPageEvent, MainState> {
  Main({required MainState initialState}) : super(initialState) {}
}
