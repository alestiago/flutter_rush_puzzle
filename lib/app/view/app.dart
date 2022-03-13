// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:puzzles_repository/puzzles_repository.dart';
import 'package:rush_hour_puzzle/l10n/l10n.dart';
import 'package:rush_hour_puzzle/puzzle/view/puzzle_page.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.puzzlesRepository,
  }) : super(key: key);

  final PuzzlesRepository puzzlesRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: puzzlesRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          ),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const PuzzleGame(),
    );
  }
}
