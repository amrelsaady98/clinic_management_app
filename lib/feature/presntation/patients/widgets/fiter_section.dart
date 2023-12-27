import 'dart:ffi';

import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patients_bloc.dart';
import 'package:clinc_management_app/feature/presntation/patients/bloc/patients_list_bloc/patients_event.dart';
import 'package:fluent_ui/fluent_ui.dart' as f;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FilterSection extends StatefulWidget {
  const FilterSection({super.key});

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  String? nameFilter;
  int? ageFilter = 20;
  String? phoneNumberFilter;
  late final translation = AppLocalizations.of(context);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      height: double.infinity,
      width: double.infinity,
      color: theme.colorScheme.surface,
      padding: EdgeInsets.all(4.mm),
      child: f.Card(
        padding: EdgeInsets.all(5.mm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 50.mm,
              child: f.TextBox(
                onChanged: (value) {
                  nameFilter = value;
                  updateFilterData();
                },

                placeholder: translation!.common_name,
                // decoration: InputDecoration(
                //   label: Text("${translation!.common_name}"),
                //   border: OutlineInputBorder(
                //       borderRadius:
                //           BorderRadius.all(Radius.circular(2.mm))),
                //   contentPadding: EdgeInsets.symmetric(
                //       vertical: 0, horizontal: 2.mm),
                // ),
              ),
            ),
            SizedBox(
              width: 2.mm,
            ),
            SizedBox(
              width: 25.mm,
              child: f.EditableComboBox<int>(
                value: ageFilter,
                elevation: 16,
                onFieldSubmitted: (value) {
                  String num = value.trim();
                  if (value.contains(RegExp(r'[a-z]')) ||
                      value.contains(RegExp(r'[A-Z]')) ||
                      value.contains(RegExp(r'[\u0621-\u064A]'))) {
                    showContentDialog(context,
                        title: translation!.common_error,
                        content: "Invalid input data");
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
                  setState(() {
                    ageFilter = value;
                  });
                  updateFilterData();
                },
              ),
            ),
            SizedBox(
              width: 2.mm,
            ),
            SizedBox(
              width: 50.mm,
              child: f.TextBox(
                onChanged: (value) {
                  phoneNumberFilter = value;
                  updateFilterData();
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                placeholder: translation!.common_phone_number,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateFilterData() {
    debugPrint("Filter Parameters : $nameFilter $ageFilter $phoneNumberFilter");
    BlocProvider.of<PatientBloc>(context).add(
      GetFilteredPateinetsEvent(
        nameFilter: nameFilter,
        ageFilter: "$ageFilter",
        phoneNumberFilter: phoneNumberFilter,
      ),
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
