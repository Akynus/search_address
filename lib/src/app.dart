import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:search_address/src/blocs/address/address_bloc.dart';
import 'package:search_address/src/models/address.dart';
import 'package:search_address/src/navigator.dart';
import 'package:search_address/src/resources/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  Widget _injectBloc({required Widget child}) {
    final dio = Dio();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AddressBloc(AddressApi(dio))),
      ],
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return _injectBloc(
      child: MaterialApp(
        locale: localizationDelegate.currentLocale,
        supportedLocales: localizationDelegate.supportedLocales,
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate,
        ],
        theme: customTheme,
        home: const AppNavigator(),
      ),
    );
  }
}
