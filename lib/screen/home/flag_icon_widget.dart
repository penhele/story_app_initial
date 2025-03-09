import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../classes/localization.dart';
import '../../data/common/common.dart';
import '../../provider/localizations_provider.dart';

class FlagIconWidget extends StatelessWidget {
  const FlagIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Flag',
      child: DropdownButtonHideUnderline(
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
      ),
    );
  }
}
