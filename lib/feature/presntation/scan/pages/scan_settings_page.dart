import 'package:clinc_management_app/feature/diomain/entities/entities.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/applicator/applicators_bloc.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/applicator/applicators_event.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_bloc.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_event.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_state.dart';
import 'package:clinc_management_app/feature/presntation/scan/widgets/add_applicator_dialog.dart';
import 'package:clinc_management_app/feature/presntation/scan/widgets/add_scan_catalog_dialog.dart';
import 'package:clinc_management_app/feature/presntation/scan/widgets/aplicators_table.dart';
import 'package:clinc_management_app/feature/presntation/scan/widgets/scan_catalog_table.dart';
import 'package:fluent_ui/fluent_ui.dart' as f;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:window_manager/window_manager.dart';

class ScanSettingsPage extends StatefulWidget {
  const ScanSettingsPage({super.key});

  @override
  State<ScanSettingsPage> createState() => _ScanSettingsPageState();
}

class _ScanSettingsPageState extends State<ScanSettingsPage> {
  late final PlutoGridStateManager stateManager;
  @override
  void initState() {
    super.initState();
    context.read<ScanCatalogBloc>().add(GetAllScanCatalogEvent());
    context.read<ApplicatorsBloc>().add(GetAllApplicatorsEvent());
  }

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
          onPressed: () {
            context.pop();
          },
        ),
      ),
      content: f.ScaffoldPage(
        header: f.PageHeader(
          title: f.Text(translation!.scan_settings_page_title),
        ),
        content: f.SingleChildScrollView(
          child: f.Container(
            padding: EdgeInsets.symmetric(
              horizontal: f.PageHeader.horizontalPadding(context),
            ),
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
                        _onAddScanCatalogPress();
                      },
                      icon: const f.Icon(f.FluentIcons.add),
                    ),
                  ],
                ),
                SizedBox(height: 2.mm),
                const ScanCatalogTable(),
                SizedBox(height: 2.mm),
                Row(
                  children: [
                    f.Text(
                      translation.scan_settings_applicators,
                      style: f.FluentTheme.of(context).typography.subtitle,
                    ),
                    SizedBox(width: 2.mm),
                    f.IconButton(
                      onPressed: () {
                        _onAddApplicatorPress();
                      },
                      icon: const f.Icon(f.FluentIcons.add),
                    ),
                  ],
                ),
                SizedBox(height: 2.mm),
                const ApplicatorsTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onAddScanCatalogPress() {
    f.showDialog(
        context: context,
        builder: (context) {
          return const AddScanCatalogDialog();
        });
  }

  void _onAddApplicatorPress() {
    f.showDialog(
        context: context,
        builder: (context) {
          return const AddApplicatorDialog();
        });
  }
}
