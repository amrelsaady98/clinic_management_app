import 'package:clinc_management_app/feature/diomain/entities/scan_cataloge.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_bloc.dart';
import 'package:clinc_management_app/feature/presntation/scan/bloc/sacn_catalog/scan_catalog_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:fluent_ui/fluent_ui.dart' as f;
import 'package:responsive_sizer/responsive_sizer.dart';

class ScanCatalogTable extends StatefulWidget {
  const ScanCatalogTable({super.key});

  @override
  State<ScanCatalogTable> createState() => _ScanCatalogTableState();
}

class _ScanCatalogTableState extends State<ScanCatalogTable> {
  List<ScanCataloge>? scanCatalogList;
  late final PlutoGridStateManager stateManager;

  final columns = [
    PlutoColumn(
      width: PlutoGridSettings.minColumnWidth,
      title: 'id',
      field: 'id',
      type: PlutoColumnType.number(format: '##'),
    ),
    PlutoColumn(
      title: 'Type',
      field: 'type',
      type: PlutoColumnType.select(ScanType.values),
    ),
    PlutoColumn(
      title: 'Area',
      field: 'area',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Sub-Area',
      field: 'subArea',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Price',
      field: 'price',
      type: PlutoColumnType.currency(
          decimalDigits: 2, locale: 'ar', symbol: 'E£'),
    ),
    PlutoColumn(
      title: 'Estimated Time',
      field: 'estimatedTime',
      type: PlutoColumnType.time(),
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

    return BlocConsumer<ScanCatalogBloc, ScanCatalogState>(
      listener: (context, state) {
        if (state.scanCatalogs?.isNotEmpty ?? false) {
          scanCatalogList = state.scanCatalogs;
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
                          const f.Text('No Preset Scans Added, Press '),
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
        scanCatalogList?.map<PlutoRow>((e) {
              return PlutoRow(cells: {
                'id': PlutoCell(value: e.id),
                'type': PlutoCell(value: e.type.name),
                'area': PlutoCell(value: e.area),
                'subArea': PlutoCell(value: e.subArea),
                'price': PlutoCell(value: e.price),
                'estimatedTime': PlutoCell(value: e.estimatedTime),
              });
            }).toList() ??
            []);
  }
}
