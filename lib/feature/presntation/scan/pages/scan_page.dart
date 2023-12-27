import 'package:fluent_ui/fluent_ui.dart' as f;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translation = AppLocalizations.of(context);
    return f.ScaffoldPage(
      header: f.PageHeader(
        title: f.Text(
          translation!.scan_page_title,
        ),
        commandBar: f.CommandBar(
          isCompact: true,
          mainAxisAlignment: MainAxisAlignment.end,
          primaryItems: [
            f.CommandBarButton(
              onPressed: () {
                context.push('/scan/settings');
              },
              label: f.Text(translation.common_settings),
              icon: const f.Icon(f.FluentIcons.settings),
            )
          ],
        ),
      ),
    );
  }
}
