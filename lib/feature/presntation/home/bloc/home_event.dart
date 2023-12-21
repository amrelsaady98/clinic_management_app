import 'package:clinc_management_app/feature/presntation/home/bloc/home_state.dart';
import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class NavigationItemClicked extends HomePageEvent {
  final SelectedHomePage selectedPage;

  const NavigationItemClicked(this.selectedPage);

  @override
  // TODO: implement props
  List<Object?> get props => [selectedPage];
}
