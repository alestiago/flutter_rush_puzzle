import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:rush_hour_puzzle/l10n/l10n.dart';
import 'package:rush_hour_puzzle/puzzle/puzzle.dart';
import 'package:share_plus/share_plus.dart';

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
      margin: const EdgeInsets.fromLTRB(8, 200, 8, 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      constraints: BoxConstraints.loose(const Size(400, 300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.winMessageTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.winMessageText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 16,
            ),
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
                  onPressed: () {
                    final history = context.read<PuzzleBloc>().state;
                    sharePuzzle(history);
                  },
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

void sharePuzzle(PuzzleState state) {
  final introMessage = '''
https://flutter-rush.web.app/  (#${DateTime.now().difference(DateTime(2022, 2, 27)).inDays})
''';
  final buffer = StringBuffer();
  for (final state in state.history) {
    if (state.lastVehicleMoved != null) {
      buffer.write(state.lastVehicleMoved?.type.emoji);
    }
  }

  var message = '''
$introMessage

${state.historyPointer}: ${buffer.toString()}
''';

  if (message.characters.length > 140) {
    final map = <VehicleType, int>{};
    for (final state in state.history) {
      final vehicle = state.lastVehicleMoved;
      if (vehicle != null) {
        map[vehicle.type] ??= 0;
        map[vehicle.type] = map[vehicle.type]! + 1;
      }
    }

    final buffer = StringBuffer();
    for (final entry in map.entries) {
      buffer.write('${entry.key.emoji}x${entry.value} ');
    }

    message = '''
$introMessage

${state.historyPointer}: ${buffer.toString()}
''';
  }

  Share.share(
    message,
  );
}

extension on VehicleType {
  String get emoji {
    switch (this) {
      case VehicleType.taxi:
        return '🚕';
      case VehicleType.police:
        return '🚓';
      case VehicleType.bus:
        return '🚌';
      case VehicleType.truck:
        return '🚛';
      case VehicleType.car:
        return '🚗';
      case VehicleType.ambulance:
        return '🚐';
    }
  }
}
