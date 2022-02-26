import 'package:fireworks/fireworks.dart' as fireworks;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush_hour_puzzle/l10n/l10n.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:zcomponents/zcomponents.dart';

class WinDialog extends StatelessWidget {
  const WinDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehicle = context.select((PuzzleBloc bloc) {
      final vehicleId = bloc.state.puzzle.jammedVehicleId;
      return bloc.state.puzzle.vehicles[vehicleId]!;
    });
    final moves = context.select((PuzzleBloc bloc) {
      return bloc.state.historyPointer;
    });
    final l10n = context.l10n;
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      constraints: BoxConstraints.loose(const Size(400, 400)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          SizedBox(
            height: 120,
            width: 120,
            child: ZIllustration(
              children: [
                ZPositioned(
                  scale: const ZVector.all(2),
                  rotate: const ZVector(tau / 6, 0, tau / 8),
                  child: ZVehicle(
                    data: vehicle,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
            l10n.winMessageTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.winMessageText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: ScoreBoardItem(
                  title: const Text('Moves'),
                  text: Text('$moves'),
                ),
              ),
              const Flexible(
                child: ScoreBoardItem(
                  title: Text('Time'),
                  text: PuzzleTimerText(),
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<PuzzleBloc>().add(const PuzzleReseted());
                  },
                  child: Text(l10n.restartButtonTitle),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(l10n.shareButtonTitle),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
