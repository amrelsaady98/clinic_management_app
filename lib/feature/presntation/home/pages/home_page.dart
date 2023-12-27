import 'package:fluent_ui/fluent_ui.dart' as f;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translation = AppLocalizations.of(context);
    return f.ScaffoldPage(
      header: f.PageHeader(
        padding: 12,
        title: Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.mm),
          child: Row(
            children: [
              Text(
                translation!.home_page_title,
                style: theme.textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
