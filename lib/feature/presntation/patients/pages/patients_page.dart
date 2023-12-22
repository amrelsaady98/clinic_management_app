import 'package:clinc_management_app/core/utils/widgets/input_widgets.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patients_event.dart';
import 'package:clinc_management_app/feature/presntation/patients/widgets/patients_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../bloc/patients_list_bloc/patient_state.dart';
import '../bloc/patients_list_bloc/patients_bloc.dart';

class PatientsPages extends StatelessWidget {
  const PatientsPages({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final translation = AppLocalizations.of(context);
    return BlocBuilder<PatientBloc, PatientState>(
      builder: (context, state) {
        print("State Type ${state.runtimeType}");
        return BlocListener<PatientBloc, PatientState>(
          listener: (context, state) {
            debugPrint("listener --> ${state.patientsList?.last.id}");
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                //Header
                SizedBox(
                  height: 30.mm,
                  width: double.infinity,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: theme.colorScheme.surfaceVariant,
                    padding: EdgeInsets.all(4.mm),
                    child: Row(
                      children: [
                        Text(
                          "${translation?.patients_data}",
                          style: theme.textTheme.titleLarge,
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AddPatientDialouge(
                                      patientState: state, onPressAdd: () {});
                                });
                          },
                          icon: Icon(FontAwesomeIcons.circlePlus),
                        )
                      ],
                    ),
                  ),
                ),
                // Search & filters
                SizedBox(
                  height: 20.mm,
                  width: double.infinity,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: theme.colorScheme.surface,
                    padding: EdgeInsets.all(4.mm),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50.mm,
                          child: TextField(
                            onChanged: (value) {
                              BlocProvider.of<PatientBloc>(context).add(
                                  GetFilteredPateinetsEvent(nameFilter: value));
                            },
                            decoration: InputDecoration(
                              label: Text("${translation?.common_name}"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.mm))),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 2.mm),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.mm,
                        ),
                        SizedBox(
                          width: 30.mm,
                          child: DropdownMenu<int>(
                            width: 30.mm,
                            label: Text("${translation?.common_age}"),
                            inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.mm))),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 2.mm),
                            ),
                            dropdownMenuEntries: [0, 1, 2, 3, 4, 5, 6]
                                .map<DropdownMenuEntry<int>>((e) {
                              return DropdownMenuEntry(
                                value: e,
                                label: "$e",
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          width: 2.mm,
                        ),
                        SizedBox(
                          width: 50.mm,
                          child: TextField(
                            onChanged: (value) =>
                                BlocProvider.of<PatientBloc>(context).add(
                                    GetFilteredPateinetsEvent(
                                        phoneNumberFilter: value)),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              label:
                                  Text("${translation?.common_phone_number}"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.mm))),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 2.mm),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Device.height - 50.mm,
                  child: Padding(
                    padding: EdgeInsets.all(2.mm),
                    child: (state.isTableLoading)
                        ? const Center(child: CircularProgressIndicator())
                        : Expanded(
                            child: PatientData(state: state),
                          ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
