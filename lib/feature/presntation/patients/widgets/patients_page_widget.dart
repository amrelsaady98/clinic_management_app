import 'package:clinc_management_app/core/utils/widgets/input_widgets.dart';
import 'package:clinc_management_app/feature/diomain/entities/patient.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patient_state.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patients_bloc.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patients_event.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPatientSection extends StatefulWidget {
  const AddPatientSection({super.key, required this.state});
  final state;
  @override
  State<AddPatientSection> createState() => _AddPatientSectionState();
}

class _AddPatientSectionState extends State<AddPatientSection> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final translation = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      padding: EdgeInsets.all(4.mm),
      margin: EdgeInsets.all(2.mm),
      alignment: AlignmentDirectional.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 50.mm,
                child: CustomTextField(
                  lable: translation!.common_name,
                  onChange: (value) => context
                      .read<PatientBloc>()
                      .add(NewPatientFieldUpdate(name: value)),
                  controller: nameController,
                ),
              ),
              SizedBox(width: 4.mm),
              SizedBox(
                width: 30.mm,
                child: DropdownMenu<int>(
                  width: 30.mm,
                  controller: ageController,
                  label: Text(translation.common_age),
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.mm))),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 2.mm),
                  ),
                  dropdownMenuEntries: List<int>.generate(99, (index) => index)
                      .map<DropdownMenuEntry<int>>((e) {
                    return DropdownMenuEntry(
                      value: e,
                      label: "$e",
                    );
                  }).toList(),
                ),
              ),
              SizedBox(width: 4.mm),
              SizedBox(
                width: 30.mm,
                child: DropdownMenu<String>(
                  width: 30.mm,
                  label: Text(translation.common_gender),
                  controller: genderController,
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.mm))),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 2.mm),
                  ),
                  dropdownMenuEntries: [
                    DropdownMenuEntry<String>(
                      label: translation.common_male,
                      value: "male",
                    ),
                    DropdownMenuEntry<String>(
                      label: translation.common_female,
                      value: "female",
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4.mm),
              SizedBox(
                width: 60.mm,
                child: CustomTextField(
                  lable: translation.common_phone_number,
                  controller: phoneNumberController,
                  inputFormatter: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) => context
                      .read<PatientBloc>()
                      .add(NewPatientFieldUpdate(phoneNumber: value)),
                ),
              ),
              SizedBox(
                width: 50.mm,
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child: TextButton(
                      onPressed: () {
                        context.read<PatientBloc>().add(AddPatientEvent(
                              patientName: nameController.text,
                              patientAge: ageController.text,
                              patientGender: genderController.text,
                              patientPhoneNumber: phoneNumberController.text,
                            ));
                      },
                      child: Text(translation.common_add)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PatientData extends StatelessWidget {
  const PatientData({super.key, required PatientState state}) : _state = state;
  final PatientState _state;

  @override
  Widget build(BuildContext context) {
    AppLocalizations? translation = AppLocalizations.of(context);
    ThemeData theme = Theme.of(context);

    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return _patientItem(context, _state.patientsList![index]);
      },
      separatorBuilder: (_, index) => const Divider(),
      itemCount: _state.patientsList!.length,
    );
  }

  Widget _patientItem(BuildContext context, Patient patient) {
    AppLocalizations? translation = AppLocalizations.of(context);
    ThemeData theme = Theme.of(context);
    return Container(
      child: Row(children: [
        Flexible(
          flex: 3,
          child: Container(
            color: Colors.amber,
            width: double.infinity,
            child: Text(
              patient.name,
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12.sp),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: Text(
              patient.age.toString(),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: Icon(
              (patient.gender == "male" || patient.gender == "ذكر")
                  ? FontAwesomeIcons.mars
                  : FontAwesomeIcons.venus,
              size: 4.mm,
            ),
          ),
        ),
        Flexible(
            flex: 1,
            child: Container(
                width: double.infinity,
                color: Colors.teal,
                child:
                    Text(patient.phoneNumber ?? translation!.common_not_exist)))
      ]),
    );
  }
}

class AddPatientDialouge extends StatefulWidget {
  AddPatientDialouge({
    super.key,
    required PatientState patientState,
    required this.onPressAdd,
  }) : state = patientState;
  PatientState state;
  void Function() onPressAdd;

  @override
  State<AddPatientDialouge> createState() => _AddPatientDialougeState();
}

class _AddPatientDialougeState extends State<AddPatientDialouge> {
  String? genderGroubValue;

  @override
  Widget build(BuildContext context) {
    AppLocalizations? translation = AppLocalizations.of(context);
    ThemeData theme = Theme.of(context);
    return AlertDialog(
      // dialog title
      title: Container(
          width: double.infinity,
          alignment: AlignmentDirectional.center,
          child: Text('${translation?.patients_page_add_new_patient}')),

      content: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${translation?.patient_page_patients_data}",
              style: theme.textTheme.titleLarge,
            ),
            SizedBox(width: 4.mm),
            SizedBox(
              width: 50.mm,
              child: CustomTextField(
                  lable: translation!.common_name,
                  onChange: (value) {
                    context
                        .read<PatientBloc>()
                        .add(NewPatientFieldUpdate(name: value));
                  }),
            ),
            SizedBox(
              width: 2.mm,
            ),
            SizedBox(
              width: 20.mm,
              child: CustomTextField(
                lable: translation.common_age,
                onChange: (value) {
                  context
                      .read<PatientBloc>()
                      .add(NewPatientFieldUpdate(age: value));
                },
              ),
            ),
            SizedBox(
              width: 2.mm,
            ),
            // SizedBox(
            //   width: 50.mm,
            //   child: DropdownMenu<String>(
            //     width: 50.mm,
            //     controller: state.addPateintGenderController,
            //     label: Text("${translation?.common_gender}"),
            //     inputDecorationTheme: InputDecorationTheme(
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(2.mm))),
            //       contentPadding:
            //           EdgeInsets.symmetric(vertical: 0, horizontal: 2.mm),
            //     ),
            //     dropdownMenuEntries: [
            //       translation!.common_male,
            //       translation.comon_female
            //     ].map<DropdownMenuEntry<String>>((e) {
            //       return DropdownMenuEntry(
            //         value: e,
            //         label: "$e",
            //       );
            //     }).toList(),
            //   ),
            // ),
            SizedBox(
              width: 2.mm,
            ),
            SizedBox(
              width: 50.mm,
              child: CustomTextField(
                  lable: translation.common_phone_number,
                  inputFormatter: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    context
                        .read<PatientBloc>()
                        .add(NewPatientFieldUpdate(phoneNumber: value));
                  }),
            ),
            SizedBox(
              width: 30.mm,
              child: RadioListTile(
                title: Text(translation.common_male),
                value: "male",
                groupValue: genderGroubValue,
                onChanged: (value) {
                  setState(() {
                    context
                        .read<PatientBloc>()
                        .add(NewPatientFieldUpdate(gender: value));
                    genderGroubValue = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: 30.mm,
              child: RadioListTile(
                title: Text(translation.common_female),
                value: "female",
                groupValue: genderGroubValue,
                onChanged: (value) {
                  setState(() {
                    context
                        .read<PatientBloc>()
                        .add(NewPatientFieldUpdate(gender: value));
                    genderGroubValue = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              BlocProvider.of<PatientBloc>(context).add(AddPatientEvent());
            },
            child: Text(translation.common_add)),
        TextButton(
          onPressed: () {
            Navigator.pop(context); //close Dialog
          },
          child: Text(translation.common_close),
        )
      ],
    );
  }
}
