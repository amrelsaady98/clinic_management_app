import 'package:clinc_management_app/feature/diomain/entities/scan_cataloge.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_bloc.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_event.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_state.dart';
import 'package:fluent_ui/fluent_ui.dart' as f;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddScanCatalogDialog extends StatefulWidget {
  const AddScanCatalogDialog({super.key});

  @override
  State<AddScanCatalogDialog> createState() => _AddScanCatalogDialogState();
}

class _AddScanCatalogDialogState extends State<AddScanCatalogDialog> {
  ScanType scanType = ScanType.XRay;
  final TextEditingController area = TextEditingController();
  final TextEditingController subArea = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController estimatedTime = TextEditingController();

  bool addProgress = false;
  void Function(void Function())? setter;
  @override
  Widget build(BuildContext context) {
    final translation = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return f.StatefulBuilder(builder: (context, setter) {
      this.setter = setter;
      return BlocConsumer<ScanCatalogBloc, ScanCatalogState>(
        listener: (context, state) {
          addProgress = state.isTableLoading;
          if (setter != null) {
            setter(() {});
          }
        },
        builder: (context, state) {
          return f.ContentDialog(
            title: const f.Text('Add preset scan'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              f.Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: f.Text('Scan Type'),
                  ),
                  Expanded(
                    flex: 2,
                    child: f.ComboBox(
                      value: scanType,
                      onChanged: (value) {
                        scanType = value ?? scanType;
                        setter(() {});
                      },
                      items: ScanType.values.map<f.ComboBoxItem>((e) {
                        return f.ComboBoxItem(
                          value: e,
                          child: f.Text(e.name),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              f.SizedBox(height: 2.mm),
              f.Row(
                children: [
                  SizedBox(height: 2.mm),
                  const Expanded(
                    flex: 1,
                    child: f.Text('Area'),
                  ),
                  Expanded(
                    flex: 2,
                    child: f.TextBox(
                      controller: area,
                    ),
                  ),
                ],
              ),
              f.SizedBox(height: 2.mm),
              f.Row(
                children: [
                  SizedBox(height: 2.mm),
                  const Expanded(
                    flex: 1,
                    child: f.Text('Sub Area'),
                  ),
                  Expanded(
                    flex: 2,
                    child: f.TextBox(
                      controller: subArea,
                    ),
                  ),
                ],
              ),
              f.SizedBox(height: 2.mm),
              f.Row(
                children: [
                  SizedBox(height: 2.mm),
                  const Expanded(
                    flex: 1,
                    child: f.Text('Price'),
                  ),
                  Expanded(
                    flex: 2,
                    child: f.TextBox(
                      controller: price,
                    ),
                  ),
                ],
              ),
              f.SizedBox(height: 2.mm),
              f.Row(
                children: [
                  SizedBox(height: 2.mm),
                  const Expanded(
                    flex: 1,
                    child: f.Text('Estimated Time'),
                  ),
                  Expanded(
                    flex: 2,
                    child: f.TextBox(
                      controller: estimatedTime,
                    ),
                  ),
                ],
              ),
              f.SizedBox(height: 2.mm),
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
                  context.read<ScanCatalogBloc>().add(
                        AddScanCatalogEvent(
                          type: scanType,
                          area: area.text,
                          subArea: subArea.text,
                          price: double.tryParse(price.text),
                          estimatedTime: int.tryParse(estimatedTime.text),
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
