import 'package:flutter/material.dart';

InputDecorationTheme get inputDecorationTheme {
  return const InputDecorationTheme(
      border: OutlineInputBorder()
  );
}

AppBarTheme get appBarTheme {
  return const AppBarTheme(
      centerTitle: true
  );
}

CardTheme get cardTheme {
  return const CardTheme(
      elevation: 10
  );
}

ThemeData get customTheme {
  return ThemeData(
    useMaterial3: false,
    primarySwatch: Colors.indigo,
    inputDecorationTheme:inputDecorationTheme,
    appBarTheme: appBarTheme,
    cardTheme: cardTheme,
  );
}