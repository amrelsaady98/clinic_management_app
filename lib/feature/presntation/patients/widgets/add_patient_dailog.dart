import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patient_state.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patients_event.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import "package:fluent_ui/fluent_ui.dart" as f;
import '../bloc/patients_list_bloc/patients_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPatientDialoug extends StatefulWidget {
  @override
  State<AddPatientDialoug> createState() => _AddPatientDialougState();
}

class _AddPatientDialougState extends State<AddPatientDialoug> {
  late final translation = AppLocalizations.of(context);
  int? ageFilter = 20;
  String? gender = 'male';
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  bool addProgress = false;
  void Function(void Function())? setter;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientBloc, PatientState>(
      listener: (context, state) {
        addProgress = state.isAddPatientLoading;
        if (setter != null) {
          setter!(() {});
        }
      },
      child: StatefulBuilder(builder: (context, setter) {
        this.setter = setter;
        return f.ContentDialog(
          title: f.Text('Add New Patient'),
          content: f.Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: f.Text('Name'),
                  ),
                  Expanded(
                    flex: 2,
                    child: f.TextFormBox(
                      controller: name,
                      errorHighlightColor: Colors.amber,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (value) {
                        String? errorMessage;
                        if (value == null) {
                          errorMessage = "Required";
                        } else if (value.trim().isEmpty) {
                          errorMessage = "Required";
                        } else if (value.isEmpty) {
                          errorMessage = "Invalid input Data";
                        }
                        return errorMessage;
                      },
                    ),
                  ),
                ],
              ),
              f.SizedBox(
                height: 2.mm,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: f.Text('Age'),
                  ),
                  Expanded(
                    flex: 2,
                    child: f.EditableComboBox<int>(
                      value: ageFilter,
                      elevation: 16,
                      onFieldSubmitted: (value) {
                        String num = value.trim();
                        if (value.contains(RegExp(r'[a-z]')) ||
                            value.contains(RegExp(r'[A-Z]')) ||
                            value.contains(RegExp(r'[\u0621-\u064A]'))) {
                          showContentDialog(
                            context,
                            title: translation!.common_error,
                            content: "Invalid input data",
                          );
                          return ageFilter.toString();
                        }
                        num = replaceFarsiNumber(value);
                        if (int.parse(num) <= 0 || int.parse(num) > 100) {
                          showContentDialog(context,
                              title: translation!.common_error,
                              content: "Age must be within 1 and 100 year");
                          return num;
                        }
                        return num;
                      },
                      placeholder: Text(translation!.common_age),
                      items: List<int>.generate(99, (index) => index)
                          .map<f.ComboBoxItem<int>>((e) {
                        return f.ComboBoxItem(
                          value: e + 1,
                          child: f.Text('${e + 1}'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setter(() {
                          ageFilter = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              f.SizedBox(
                height: 2.mm,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: f.Text('Gender'),
                  ),
                  Expanded(
                    flex: 2,
                    child: f.ComboBox(
                      value: gender,
                      onChanged: (value) {
                        gender = value;
                        setter(() {});
                      },
                      items: [
                        f.ComboBoxItem(
                          child: f.Text('male'),
                          value: 'male',
                        ),
                        f.ComboBoxItem(
                          child: f.Text('female'),
                          value: 'female',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              f.SizedBox(
                height: 2.mm,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: f.Text('Phone Number'),
                  ),
                  Expanded(
                    flex: 2,
                    child: f.TextBox(
                      controller: phoneNumber,
                    ),
                  ),
                ],
              ),
              f.SizedBox(
                height: 2.mm,
              ),
            ],
          ),
          actions: [
            f.Button(
              onPressed: () {
                context.pop();
              },
              child: f.Text('close'),
            ),
            f.FilledButton(
              onPressed: () {
                addProgress = true;
                setter(() {});
                context.read<PatientBloc>().add(
                      AddPatientEvent(
                        patientName: name.text,
                        patientAge: ageFilter,
                        patientGender: gender,
                        patientPhoneNumber: phoneNumber.text,
                      ),
                    );
              },
              child: addProgress
                  ? f.Center(
                      child: f.SizedBox(
                          height: 4.mm,
                          width: 4.mm,
                          child: const f.ProgressRing(
                            strokeWidth: 2.5,
                          )),
                    )
                  : f.Text(translation!.common_add),
            ),
          ],
        );
      }),
    );
  }

  void showContentDialog(BuildContext context,
      {required String title, String? content}) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => f.ContentDialog(
        title: Text(title),
        content: Text(
          '$content',
        ),
        actions: [
          f.FilledButton(
            child: Text(translation!.common_ok),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
    setState(() {});
  }

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = [
      '٠',
      '١',
      '٢',
      '٣',
      '٤',
      '٥',
      '٦',
      '٧',
      '٨',
      '٩',
    ];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(farsi[i], english[i]);
    }

    return input;
  }
}
