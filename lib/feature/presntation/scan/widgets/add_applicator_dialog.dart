import 'package:clinc_management_app/feature/diomain/entities/scan_cataloge.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/applicator/applicators_bloc.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/applicator/applicators_event.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/applicator/applicators_state.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_bloc.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_event.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_state.dart';
import 'package:fluent_ui/fluent_ui.dart' as f;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddApplicatorDialog extends StatefulWidget {
  const AddApplicatorDialog({super.key});

  @override
  State<AddApplicatorDialog> createState() => _AddApplicatorDialogState();
}

class _AddApplicatorDialogState extends State<AddApplicatorDialog> {
  final TextEditingController name = TextEditingController();

  bool addProgress = false;
  void Function(void Function())? setter;
  @override
  Widget build(BuildContext context) {
    final translation = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return f.StatefulBuilder(builder: (context, setter) {
      this.setter = setter;
      return BlocConsumer<ApplicatorsBloc, ApplicatorsState>(
        listener: (context, state) {
          addProgress = state.isTableLoading;
          if (setter != null) {
            setter(() {});
          }
        },
        builder: (context, state) {
          return f.ContentDialog(
            title: const f.Text('Add New Applicator'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              f.Row(
                children: [
                  SizedBox(height: 2.mm),
                  const Expanded(
                    flex: 1,
                    child: f.Text('Name'),
                  ),
                  Expanded(
                    flex: 2,
                    child: f.TextBox(
                      controller: name,
                    ),
                  ),
                ],
              ),
            ]),
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
                  context.read<ApplicatorsBloc>().add(
                        AddApplicatorEvent(
                          name: name.text,
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
        },
      );
    });
  }
}
