// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzles_repository/puzzles_repository.dart';

import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:rush_hour_puzzle/timer/timer.dart';

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TimerBloc(
            ticker: const Ticker(),
          ),
        ),
        BlocProvider(
          create: (_) => PuzzleBloc(
            puzzlesRepository: context.read<PuzzlesRepository>(),
          )..add(const PuzzleFetched()),
        ),
      ],
      child: const PuzzleView(),
    );
  }
}
