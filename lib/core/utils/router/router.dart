import 'package:clinc_management_app/feature/presntation/home/pages/home_page.dart';
import 'package:clinc_management_app/feature/presntation/main/pages/main_page.dart';
import 'package:clinc_management_app/feature/presntation/patients/pages/patients_page.dart';
import 'package:clinc_management_app/feature/presntation/scan/pages/scan_page.dart';
import 'package:clinc_management_app/feature/presntation/scan/pages/scan_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(navigatorKey: rootNavigatorKey, routes: [
  ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainPage(
          shellContext: _shellNavigatorKey.currentContext,
          child: child,
        );
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(
            path: '/patients',
            builder: (context, state) => const PatientsPage()),
        GoRoute(path: '/scan', builder: (context, state) => const ScanPage()),
        GoRoute(path: '/scan', builder: (context, state) => const ScanPage()),
        GoRoute(
            path: '/scan/settings',
            builder: (context, state) => const ScanSettingsPage()),
      ])
]);
