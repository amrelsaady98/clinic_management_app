import 'package:clinc_management_app/feature/presntation/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DarwerItem extends StatelessWidget {
  const DarwerItem(
      {super.key,
      required this.context,
      required this.seletedPage,
      required this.state,
      required this.icon,
      required this.onTap});

  final BuildContext context;
  final SelectedHomePage seletedPage;
  final HomeState state;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
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
            child: Icon(icon,
                size: state.selectedHomePage == seletedPage ? 12.mm : 10.mm,
                color: theme.colorScheme.primary),
          ),
          Text(
            seletedPage.name,
            style: state.selectedHomePage == seletedPage
                ? theme.textTheme.labelLarge
                    ?.copyWith(color: theme.colorScheme.surface)
                : theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.surfaceVariant,
                  ),
          ),
        ],
      ),
    );
  }
}
