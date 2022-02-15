// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zcomponents/zcomponents.dart';
import 'package:rush_hour_puzzle/counter/counter.dart';
import 'package:rush_hour_puzzle/l10n/l10n.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final PageController _pageController = PageController(viewportFraction: 0.7);

  Key? selected;

  final themes = [
    BoardThemeData.fromMaterialColor(Colors.blue),
    BoardThemeData.fromMaterialColor(Colors.green),
    BoardThemeData.fromMaterialColor(Colors.red),
    BoardThemeData.fromMaterialColor(Colors.purple),
  ];

  late final Animatable<Color?> background = TweenSequence<Color?>([
    for (int index = 0; index < (themes.length - 1); index++)
      TweenSequenceItem(
        weight: 1,
        tween: ColorTween(
          begin: themes[index].backgroundColor,
          end: themes[index + 1].backgroundColor,
        ),
      ),
  ]);
  @override
  Widget build(BuildContext context) {
    final ZTransform chooseState = ZTransform(
      rotate: ZVector.only(x: -0.25, y: -0.75),
    );
    final ZTransform play2d = ZTransform(
      scale: ZVector.all(1.2),
    );
    final ZTransform play3d = ZTransform(
      scale: ZVector.all(2),
      rotate: ZVector.only(x: 1.2, y: -0.2, z: -0.5),
    );
    final l10n = context.l10n;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          final color =
              _pageController.hasClients ? _pageController.page! / 3 : .0;

          return DecoratedBox(
            decoration: BoxDecoration(
              color: background.transform(color),
            ),
            child: child,
          );
        },
        child: PageView(
          physics: selected != null ? NeverScrollableScrollPhysics() : null,
          controller: _pageController,
          children: [
            for (int index = 0; index < themes.length; index++)
              if (selected == null || selected == ValueKey(index))
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  key: ValueKey(index),
                  onTap: () {
                    setState(() {
                      selected = ValueKey(index);
                    });
                  },
                  child: ZGame(
                    theme: themes[index],
                    transform: selected != null ? play2d : chooseState,
                  ),
                )
              else
                SizedBox(),
          ],
        ),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.headline1);
  }
}
