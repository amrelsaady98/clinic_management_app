import 'package:clinc_management_app/core/nertwork/local/database.dart';
import 'package:clinc_management_app/core/utils/router/router.dart';
import 'package:clinc_management_app/feature/data/repos/patient_repo.dart';
import 'package:clinc_management_app/feature/presntation/main/bloc/main_bloc.dart';
import 'package:clinc_management_app/feature/presntation/main/bloc/main_state.dart';

import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patient_state.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patients_bloc.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patients_event.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String appTitle = 'Win UI for Flutter';

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.android,
      ].contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    if (defaultTargetPlatform == TargetPlatform.windows) {
      await flutter_acrylic.Window.hideWindowControls();
    }
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.normal,
        windowButtonVisibility: true,
      );
      await windowManager.setMinimumSize(const Size(500, 600));
      await windowManager.show();
      await windowManager.setPreventClose(false);
      await windowManager.setSkipTaskbar(false);
    });
  }
  AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(MyApp(
    appDatabase: database,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required AppDatabase appDatabase})
      : _appDatabase = appDatabase;
  final AppDatabase _appDatabase;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<Main>(
          create: (context) => Main(initialState: MainState.initialState()),
        ),
        BlocProvider<PatientBloc>(
          create: (context) => PatientBloc(
              initialState: const PatientState(isTableLoading: true),
              patientsRepo: PatientsRepo(_appDatabase.patientDao))
            ..add(const GetAllPatientsEvent()),
        ),
      ],
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return FluentApp.router(
          title: appTitle,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: const Locale('en'),
          supportedLocales: const [
            Locale('en', ''),
            Locale('ar', ''),
          ],
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
          builder: (context, child) {
            return NavigationPaneTheme(
                data: NavigationPaneThemeData(), child: child!);
          },
        );
      }),
    );
  }
}
