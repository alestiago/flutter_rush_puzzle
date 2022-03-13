// ignore_for_file: public_member_api_docs, cast_nullable_to_non_nullable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:rush_hour_puzzle/vehicle/vehicle.dart';

import 'package:zcomponents/zcomponents.dart';

class PerspectiveSegmentedControl extends StatelessWidget {
  const PerspectiveSegmentedControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pespective = context.select((PuzzleBloc b) => b.state.perspective);
    return CupertinoSlidingSegmentedControl<GameLayoutPerspective>(
      groupValue: pespective,
      onValueChanged: (value) {
        context
            .read<PuzzleBloc>()
            .add(PuzzlePerspectiveChanged(value ?? GameLayoutPerspective.p3D));
      },
      children: {
        GameLayoutPerspective.p2D: Text('2D'),
        GameLayoutPerspective.p3D: Text('3D'),
      },
    );
  }
}