import 'dart:convert';

import 'package:clinc_management_app/core/utils/widgets/input_widgets.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patients_event.dart';
import 'package:clinc_management_app/feature/presntation/patients/widgets/add_patient_dailog.dart';
import 'package:clinc_management_app/feature/presntation/patients/widgets/fiter_section.dart';
import 'package:clinc_management_app/feature/presntation/patients/widgets/patients_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import "package:fluent_ui/fluent_ui.dart" as f;
import 'package:window_manager/window_manager.dart';

import '../bloc/patients_list_bloc/patient_state.dart';
import '../bloc/patients_list_bloc/patients_bloc.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> with WindowListener {
  late final translation = AppLocalizations.of(context);
  int? ageFilter = 20;
  String? gender = 'male';
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  bool addProgress = false;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void onWindowResized() {
    setState(() {});
    super.onWindowResized();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<PatientBloc, PatientState>(
      builder: (context, state) {
        print("State Type ${state.runtimeType}");
        return f.ScaffoldPage(
          header: f.PageHeader(
            padding: 12,
            title: Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.mm),
              child: Row(
                children: [
                  Text(
                    "${translation?.patients_data}",
                    style: theme.textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () {
                      f.showDialog(
                          context: context,
                          builder: (context) {
                            return AddPatientDialoug();
                          });
                    },
                    icon: Icon(f.FluentIcons.add),
                  )
                ],
              ),
            ),
          ),
          content: Column(
            children: [
              Visibility(
                visible: false,
                child: SizedBox(
                    height: 30.mm,
                    child: AddPatientSection(
                      state: state,
                    )),
              ),
              // Search & filters
              SizedBox(
                height: 30.mm,
                child: const FilterSection(),
              ),
              Expanded(
                child: (state.isTableLoading)
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: PatientData(state: state),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
