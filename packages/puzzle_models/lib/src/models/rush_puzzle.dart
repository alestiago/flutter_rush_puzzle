import 'package:equatable/equatable.dart';
import 'package:puzzle_models/puzzle_models.dart';

/// {@template rush_puzzle}
/// Represents a Rush Hour puzzle.
///
/// For more information see:
/// - https://en.wikipedia.org/wiki/Rush_Hour_(puzzle)
/// {@endtemplate}
class RushPuzzle extends Equatable {
  /// {@macro rush_puzzle}
  RushPuzzle({
    required this.exit,
    required this.jammedVehicle,
    required this.dimension,
    required this.vehicles,
  })  : assert(
          vehicles.contains(jammedVehicle),
          'Jammed vehicle not in state',
        ),
        assert(
          vehicles.every(
            (vehicle) =>
                (vehicle.firstPosition <= dimension &&
                    vehicle.lastPosition <= dimension) ||
                (vehicle == jammedVehicle && vehicle.firstPosition == exit),
          ),
          'One or more vehicles are out out of bounds',
        );

  /// All the [Vehicle]s in the puzzle.
  ///
  /// This includes the [jammedVehicle].
  final List<Vehicle> vehicles;

  /// The [Position] that the [jammedVehicle] has to reach in order to solve
  /// the puzzle.
  final Position exit;

  /// The size of the puzzle.
  ///
  /// The [Position] indicates the bottom right corner of the puzzle.
  final Position dimension;

  /// The [Vehicle] that is jammed in the puzzle and must reach the [exit].
  final Vehicle jammedVehicle;

  /// Asess if the puzzle is solved.
  ///
  /// A puzzle is solved if the [jammedVehicle] reaches the [exit].
  bool get isSolved {
    return jammedVehicle.firstPosition == exit;
  }

  @override
  List<Object?> get props => [
        vehicles,
        exit,
        dimension,
        jammedVehicle,
      ];
}
