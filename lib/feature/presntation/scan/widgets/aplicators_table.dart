import 'package:clinc_management_app/feature/diomain/entities/entities.dart';
import 'package:clinc_management_app/feature/diomain/entities/scan_cataloge.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/applicator/applicators_bloc.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/applicator/applicators_state.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_bloc.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:fluent_ui/fluent_ui.dart' as f;
import 'package:responsive_sizer/responsive_sizer.dart';

class ApplicatorsTable extends StatefulWidget {
  const ApplicatorsTable({super.key});

  @override
  State<ApplicatorsTable> createState() => _ApplicatorsTableState();
}

class _ApplicatorsTableState extends State<ApplicatorsTable> {
  List<Applicator>? applicatorsList;
  late final PlutoGridStateManager stateManager;

  final columns = [
    PlutoColumn(
      width: PlutoGridSettings.minColumnWidth,
      title: 'id',
      field: 'id',
      type: PlutoColumnType.number(format: '##'),
    ),
    PlutoColumn(
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.select(ScanType.values),
    ),
  ];

  @override
  void initState() {
    loadTableData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final translation = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocConsumer<ApplicatorsBloc, ApplicatorsState>(
      listener: (context, state) {
        if (state.applicators?.isNotEmpty ?? false) {
          applicatorsList = state.applicators;
          loadTableData();
        }
      },
      builder: (context, state) {
        return Material(
          child: f.Container(
            height: 50.mm,
            child: PlutoGrid(
              columns: columns,
              mode: PlutoGridMode.readOnly,
              onLoaded: (onChange) => stateManager = onChange.stateManager,
              onChanged: (onChange) {
                debugPrint(onChange.toString());
              },
              noRowsWidget: state.isTableLoading
                  ? const f.Center(child: f.ProgressBar())
                  : f.Center(
                      child: f.Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const f.Text('No Applicators Added, Press '),
                          f.Icon(f.FluentIcons.add, size: 3.mm),
                          const f.Text(' To Add One.'),
                        ],
                      ),
                    ),
              rows: [],
            ),
          ),
        );
      },
    );
  }

  void loadTableData() async {
    stateManager.removeAllRows();
    stateManager.insertRows(
        0,
        applicatorsList?.map<PlutoRow>((e) {
              return PlutoRow(cells: {
                'id': PlutoCell(value: e.id),
                'name': PlutoCell(value: e.name),
              });
            }).toList() ??
            []);
  }
}
