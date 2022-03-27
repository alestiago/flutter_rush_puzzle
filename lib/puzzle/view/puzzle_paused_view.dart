// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';

import 'package:z_cubic_text/z_cubic_text.dart';
import 'package:zcomponents/zcomponents.dart';

class PuzzlePausedView extends StatelessWidget {
  const PuzzlePausedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final zStyle = ZCubicTextStyle(
      fontSize: 14,
      letterSpacing: 12,
      frontColor: Colors.grey[800],
    );
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: Container(
        color: Colors.blue[100]!.withOpacity(0.7),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 160),
                  SizedBox(
                    height: 100,
                    width: 400,
                    child: ZIllustration(
                      children: [
                        ZAnimatedPositioned.position(
                          duration: const Duration(milliseconds: 200),
                          position: const ZPosition(
                            rotate: ZVector.only(x: -0.25, y: -0.5),
                          ),
                          child: ZPositioned(
                            translate: const ZVector.only(x: 16),
                            child: ZCubicText(
                              'PAUSED',
                              style: zStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                PuzzlePausedTile(
                  icon: const Icon(Icons.help),
                  title: const Text('Show Instructions'),
                  onPressed: () {
                    context.read<PuzzleBloc>().add(
                          const PuzzleTutorialStarted(),
                        );
                  },
                ),
                PuzzlePausedTile(
                  icon: const Icon(Icons.restart_alt),
                  title: const Text('Restart'),
                  onPressed: () {
                    context.read<PuzzleBloc>().add(const PuzzleReseted());
                  },
                ),
                const SizedBox(height: 48),
                PuzzlePausedTile(
                  icon: const Icon(
                    Icons.play_arrow,
                  ),
                  title: const Text('Continue'),
                  onPressed: () {
                    context.read<PuzzleBloc>().add(const PuzzleResumed());
                  },
                ),
              ]),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 120))
          ],
        ),
      ),
    );
  }
}
