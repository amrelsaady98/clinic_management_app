import 'package:clinc_management_app/feature/diomain/entities/entities.dart';
import 'package:fluent_ui/fluent_ui.dart' as f;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:window_manager/window_manager.dart';

class ScanSettingsPage extends StatefulWidget {
  const ScanSettingsPage({super.key});

  @override
  State<ScanSettingsPage> createState() => _ScanSettingsPageState();
}

class _ScanSettingsPageState extends State<ScanSettingsPage> {
  ScanType scanType = ScanType.XRay;
  final TextEditingController area = TextEditingController();
  final TextEditingController subArea = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController estimatedTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final translation = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return f.NavigationView(
      appBar: f.NavigationAppBar(
        title: () {
          final title = Text(translation!.scan_settings_page_title);

          if (kIsWeb) return title;

          return DragToMoveArea(child: title);
        }(),
        leading: f.IconButton(
          icon: const f.Icon(f.FluentIcons.back),
          onPressed: () => context.pop(),
        ),
      ),
      content: f.ScaffoldPage(
        header: f.PageHeader(
          title: f.Text(translation!.scan_settings_page_title),
        ),
        content: f.SingleChildScrollView(
          child: f.Container(
            padding: EdgeInsets.symmetric(
                horizontal: f.PageHeader.horizontalPadding(context)),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    f.Text(
                      translation.scan_settings_preset_scans,
                      style: f.FluentTheme.of(context).typography.subtitle,
                    ),
                    SizedBox(width: 2.mm),
                    f.IconButton(
                      onPressed: () {
                        // Show Add Scan Catalog dialog
                        f.showDialog(
                            context: context,
                            builder: (context) {
                              return f.ContentDialog(
                                title: const f.Text('Add preset scan'),
                                content: StatefulBuilder(
                                    builder: (context, StateSetter setter) {
                                  return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        f.Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: f.Text('Type'),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: f.ComboBox(
                                                value: scanType,
                                                onChanged: (value) {
                                                  scanType = value ?? scanType;
                                                  setter(() {});
                                                },
                                                items: ScanType.values
                                                    .map<f.ComboBoxItem>((e) {
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
                                              child: f.Text('Type'),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: f.TextBox(),
                                            ),
                                          ],
                                        ),
                                        f.SizedBox(height: 2.mm),
                                      ]);
                                }),
                              );
                            });
                      },
                      icon: const f.Icon(f.FluentIcons.add),
                    )
                  ],
                ),
                SizedBox(height: 2.mm),
                Material(
                  child: f.Container(
                    height: 120,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
