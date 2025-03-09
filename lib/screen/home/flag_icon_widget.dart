import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_initial/classes/localization.dart';
import 'package:story_app_initial/data/common/common.dart';
import 'package:story_app_initial/provider/localizations_provider.dart';

class FlagIconWidget extends StatelessWidget {
  const FlagIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: const Icon(Icons.flag),
        items:
            AppLocalizations.supportedLocales.map((Locale locale) {
              final flag = Localization.getFlag(locale.languageCode);
              return DropdownMenuItem(
                value: locale,
                child: Center(
                  child: Text(
                    flag,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                onTap: () {
                  final provider = Provider.of<LocalizationProvider>(
                    context,
                    listen: false,
                  );
                  provider.setLocale(locale);
                },
              );
            }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
