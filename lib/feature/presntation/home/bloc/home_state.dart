import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final SelectedHomePage selectedHomePage;

  const HomeState(this.selectedHomePage);

  factory HomeState.initialState() => HomeState(SelectedHomePage.Home);
  @override
  List<Object?> get props => [selectedHomePage];
}

enum SelectedHomePage { Home, Patients, Reservations }
