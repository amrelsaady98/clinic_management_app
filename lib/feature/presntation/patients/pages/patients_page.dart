import 'dart:convert';

import 'package:clinc_management_app/core/utils/widgets/input_widgets.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patients_event.dart';
import 'package:clinc_management_app/feature/presntation/patients/widgets/fiter_section.dart';
import 'package:clinc_management_app/feature/presntation/patients/widgets/patients_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final translation = AppLocalizations.of(context);
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
                            return f.ContentDialog(
                              content: f.SizedBox(
                                height: 30.mm,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(width: 40.mm, child: f.TextBox()),
                                    SizedBox(width: 40.mm, child: f.TextBox()),
                                  ],
                                ),
                              ),
                            );
                          });
                      if (!state.addPatientVisible) {
                        context
                            .read<PatientBloc>()
                            .add(ViewAddPatientSection());
                      } else {
                        context
                            .read<PatientBloc>()
                            .add(HideAddPatientSection());
                      }
                    },
                    icon: Icon(
                      !state.addPatientVisible
                          ? f.FluentIcons.add
                          : f.FluentIcons.remove,
                    ),
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
