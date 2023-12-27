import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  const MainState();

  factory MainState.initialState() => MainState();
  @override
  List<Object?> get props => [];
}

enum SelectedHomePage { Home, Patients, Reservations }
