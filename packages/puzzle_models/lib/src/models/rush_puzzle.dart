import 'package:equatable/equatable.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:puzzle_models/src/models/puzzle_difficulty.dart';

/// {@template rush_puzzle}
/// Represents a Rush Hour puzzle.
///
/// For more information see:
/// - https://en.wikipedia.org/wiki/Rush_Hour_(puzzle)
/// {@endtemplate}
class RushPuzzle extends Equatable {
  /// {@macro rush_puzzle}
  RushPuzzle({
    required this.difficulty,
    required this.jammedVehicleId,
    required this.vehicles,
  })  : assert(
          vehicles.values.any((v) => v.id == jammedVehicleId),
          'Jammed vehicle not in state',
        ),
        assert(
          vehicles.values.every(
            (vehicle) =>
                (vehicle.firstPosition <= dimension &&
                    vehicle.lastPosition <= dimension) ||
                (vehicle.id == jammedVehicleId &&
                    vehicle.firstPosition == exit),
          ),
          'One or more vehicles are out out of bounds',
        );

  /// The [Position] that the [jammedVehicleId] has to reach in order to solve
  /// the puzzle.
  static const Position exit = Position(6, 2);

  /// The size of the puzzle.
  ///
  /// The [Position] indicates the bottom right corner of the puzzle.
  static const Position dimension = Position(5, 5);

  /// All the [Vehicle]s in the puzzle.
  ///
  /// This includes the [jammedVehicleId].
  final Map<String, Vehicle> vehicles;

  /// The id of the [Vehicle] that is jammed (stuck) and must reach the [exit].
  final String jammedVehicleId;

  /// {@macro puzzle_difficulty}
  final PuzzleDifficulty difficulty;

  /// Asess if the puzzle is solved.
  ///
  /// A puzzle is solved if the [jammedVehicleId] reaches the [exit].
  bool get isSolved {
    return vehicles[jammedVehicleId]!.firstPosition <= exit;
  }

  // ignore: public_member_api_docs
  RushPuzzle copyWith({
    Map<String, Vehicle>? vehicles,
    String? jammedVehicleId,
    PuzzleDifficulty? difficulty,
  }) {
    return RushPuzzle(
      jammedVehicleId: jammedVehicleId ?? this.jammedVehicleId,
      vehicles: vehicles ?? this.vehicles,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  @override
  List<Object?> get props => [
        vehicles,
        exit,
        dimension,
        jammedVehicleId,
        difficulty,
      ];
}
