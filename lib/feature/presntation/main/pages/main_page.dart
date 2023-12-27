/* import 'package:clinc_management_app/feature/presntation/home/bloc/home_bloc.dart';
import 'package:clinc_management_app/feature/presntation/home/bloc/home_event.dart';
import 'package:clinc_management_app/feature/presntation/home/bloc/home_state.dart';
import 'package:clinc_management_app/feature/presntation/home/widgets/home_widgets.dart';
import 'package:clinc_management_app/feature/presntation/patients/pages/patients_page.dart'; */
/* import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart'; */
import 'package:clinc_management_app/core/utils/router/router.dart';
import 'package:clinc_management_app/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

/* class HomePage extends StatelessWidget {
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
} */

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.child,
    this.shellContext,
  });

  final Widget child;
  final BuildContext? shellContext;

  @override
  State<MainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> with WindowListener {
  final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  late final List<NavigationPaneItem> originalItems = [
    PaneItem(
      key: const ValueKey('/'),
      title: const Text('Home'),
      icon: const Icon(FluentIcons.home),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/patients'),
      title: const Text('Patients Data'),
      icon: const Icon(FluentIcons.contact),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/scan'),
      title: const Text('Scans '),
      icon: const Icon(FluentIcons.site_scan),
      body: const SizedBox.shrink(),
    ),
  ].map<NavigationPaneItem>((e) {
    PaneItem buildPaneItem(PaneItem item) {
      return PaneItem(
        key: item.key,
        icon: item.icon,
        title: item.title,
        body: item.body,
        onTap: () {
          final path = (item.key as ValueKey).value;
          if (GoRouterState.of(context).uri.toString() != path) {
            context.go(path);
          }
          item.onTap?.call();
        },
      );
    }

    if (e is PaneItemExpander) {
      return PaneItemExpander(
        key: e.key,
        icon: e.icon,
        title: e.title,
        body: e.body,
        items: e.items.map((item) {
          if (item is PaneItem) return buildPaneItem(item);
          return item;
        }).toList(),
      );
    }
    if (e is PaneItem) return buildPaneItem(e);
    return e;
  }).toList();
  late final List<NavigationPaneItem> footerItems = [
    PaneItemSeparator(),
    PaneItem(
      key: const ValueKey('/settings'),
      icon: const Icon(FluentIcons.settings),
      title: const Text('Settings'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (GoRouterState.of(context).uri.toString() != '/settings') {
          context.go('/settings');
        }
      },
    ),
  ];

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    if (widget.shellContext != null) {
      if (router.canPop() == false) {
        setState(() {});
      }
    }
    return NavigationView(
      key: viewKey,
      paneBodyBuilder: (item, child) {
        final name =
            item?.key is ValueKey ? (item!.key as ValueKey).value : null;
        return FocusTraversalGroup(
          key: ValueKey('body$name'),
          child: widget.child,
        );
      },
      pane: NavigationPane(
        selected: _calculateSelectedIndex(context),
        header: SizedBox(
          height: kOneLineTileHeight,
          child: ShaderMask(
            shaderCallback: (rect) {
              final color = AppTheme().color.defaultBrushFor(
                    theme.brightness,
                  );
              return LinearGradient(
                colors: [
                  color,
                  color,
                ],
              ).createShader(rect);
            },
            child: const FlutterLogo(
              style: FlutterLogoStyle.horizontal,
              size: 80.0,
              textColor: Colors.white,
              duration: Duration.zero,
            ),
          ),
        ),
        displayMode: PaneDisplayMode.compact,
        items: originalItems,
        footerItems: footerItems,
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    int indexOriginal = originalItems
        .where((item) => item.key != null)
        .toList()
        .indexWhere((item) => item.key == Key(location));

    if (indexOriginal == -1) {
      int indexFooter = footerItems
          .where((element) => element.key != null)
          .toList()
          .indexWhere((element) => element.key == Key(location));
      if (indexFooter == -1) {
        return 0;
      }
      return originalItems
              .where((element) => element.key != null)
              .toList()
              .length +
          indexFooter;
    } else {
      return indexOriginal;
    }
  }
}
