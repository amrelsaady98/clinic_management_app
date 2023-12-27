import 'package:clinc_management_app/core/nertwork/local/database.dart';
import 'package:clinc_management_app/core/utils/theme/app_theme.dart';
import 'package:clinc_management_app/feature/data/repos/patient_repo.dart';
import 'package:clinc_management_app/feature/presntation/main/bloc/main_bloc.dart';
import 'package:clinc_management_app/feature/presntation/main/bloc/main_state.dart';
import 'package:clinc_management_app/feature/presntation/main/pages/main_page.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patient_state.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patients_bloc.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patients_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main_old() async {
  AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(MainApp(
    appDatabase: database,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required AppDatabase appDatabase})
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
      child: ResponsiveSizer(builder: (context, orientaion, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          /* home: const HomePage(), */
          theme: app_theme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: const Locale('ar'),
          supportedLocales: const [
            Locale('en', ''),
            Locale('ar', ''),
          ],
        );
      }),
    );
  }
}
