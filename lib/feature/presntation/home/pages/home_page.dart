import 'package:clinc_management_app/feature/presntation/home/bloc/home_bloc.dart';
import 'package:clinc_management_app/feature/presntation/home/bloc/home_event.dart';
import 'package:clinc_management_app/feature/presntation/home/bloc/home_state.dart';
import 'package:clinc_management_app/feature/presntation/home/widgets/home_widgets.dart';
import 'package:clinc_management_app/feature/presntation/patients/pages/patients_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        ThemeData theme = Theme.of(context);
        debugPrint("Home selected page --> ${state.selectedHomePage}");
        return Container(
          child: Row(
            children: [
              Container(
                height: double.infinity,
                width: 30.mm,
                color: theme.colorScheme.primary,
                child: Column(
                  children: [
                    DarwerItem(
                      context: context,
                      state: state,
                      seletedPage: SelectedHomePage.Home,
                      icon: FontAwesomeIcons.houseChimney,
                      onTap: () => BlocProvider.of<HomeBloc>(context).add(
                          const NavigationItemClicked(SelectedHomePage.Home)),
                    ),
                    DarwerItem(
                      context: context,
                      state: state,
                      seletedPage: SelectedHomePage.Patients,
                      icon: FontAwesomeIcons.userGroup,
                      onTap: () => BlocProvider.of<HomeBloc>(context).add(
                          const NavigationItemClicked(
                              SelectedHomePage.Patients)),
                    ),
                    DarwerItem(
                      context: context,
                      state: state,
                      seletedPage: SelectedHomePage.Reservations,
                      icon: FontAwesomeIcons.receipt,
                      onTap: () => BlocProvider.of<HomeBloc>(context).add(
                          const NavigationItemClicked(
                              SelectedHomePage.Reservations)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: state.selectedHomePage == SelectedHomePage.Home
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.red,
                        )
                      : state.selectedHomePage == SelectedHomePage.Patients
                          ? PatientsPages()
                          : state.selectedHomePage ==
                                  SelectedHomePage.Reservations
                              ? Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  color: Colors.blueGrey,
                                )
                              : Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  color: Colors.black,
                                ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _BuildHomePageItem({
    required BuildContext context,
    required HomeState state,
    required SelectedHomePage seletedPage,
    required IconData icon,
    required void Function() onTap,
  }) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: state.selectedHomePage == seletedPage ? 22.mm : 18.mm,
            height: state.selectedHomePage == seletedPage ? 22.mm : 18.mm,
            margin: EdgeInsets.symmetric(vertical: 2.mm),
            decoration: BoxDecoration(
              color: state.selectedHomePage == seletedPage
                  ? theme.colorScheme.surface
                  : theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(2.mm),
            ),
            child: Icon(icon, size: 12.mm, color: theme.colorScheme.primary),
          ),
          Text(
            "${seletedPage.name}",
            style: state.selectedHomePage != seletedPage
                ? theme.textTheme.labelMedium
                    ?.copyWith(color: theme.colorScheme.surface)
                : theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.surfaceVariant,
                  ),
          ),
        ],
      ),
    );
  }
}
