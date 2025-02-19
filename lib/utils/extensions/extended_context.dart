import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ExtendedContext on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;

}