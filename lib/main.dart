import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:search_address/src/app.dart';
import 'package:intl/intl.dart';

void main() async {
  Intl.defaultLocale = 'pt_BR';
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'pt_BR',
    supportedLocales: ['pt_BR'],
  );

  runApp(LocalizedApp(delegate, const App()));
}
