import 'package:clinc_management_app/feature/presntation/main/bloc/main_state.dart';
import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();
}

class NavigationItemClicked extends MainPageEvent {
  final SelectedHomePage selectedPage;

  const NavigationItemClicked(this.selectedPage);

  @override
  // TODO: implement props
  List<Object?> get props => [selectedPage];
}
