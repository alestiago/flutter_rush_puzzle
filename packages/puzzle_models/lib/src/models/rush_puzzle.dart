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
    required this.jammedVehicle,
    required this.vehicles,
  })  : assert(
          vehicles.values.any((v) => v.id == jammedVehicle.id),
          'Jammed vehicle not in state',
        ),
        assert(
          vehicles.values.every(
            (vehicle) =>
                (vehicle.firstPosition <= dimension &&
                    vehicle.lastPosition <= dimension) ||
                (vehicle == jammedVehicle && vehicle.firstPosition == exit),
          ),
          'One or more vehicles are out out of bounds',
        );

  /// The [Position] that the [jammedVehicle] has to reach in order to solve
  /// the puzzle.
  static const Position exit = Position(6, 2);

  /// The size of the puzzle.
  ///
  /// The [Position] indicates the bottom right corner of the puzzle.
  static const Position dimension = Position(5, 5);

  /// All the [Vehicle]s in the puzzle.
  ///
  /// This includes the [jammedVehicle].
  final Map<String, Vehicle> vehicles;

  /// The [Vehicle] that is jammed in the puzzle and must reach the [exit].
  final Vehicle jammedVehicle;

  /// Asess if the puzzle is solved.
  ///
  /// A puzzle is solved if the [jammedVehicle] reaches the [exit].
  bool get isSolved {
    return jammedVehicle.firstPosition == exit;
  }

  // ignore: public_member_api_docs
  RushPuzzle copyWith({
    Map<String, Vehicle>? vehicles,
    Vehicle? jammedVehicle,
  }) {
    return RushPuzzle(
      jammedVehicle: jammedVehicle ?? this.jammedVehicle,
      vehicles: vehicles ?? this.vehicles,
    );
  }

  @override
  List<Object?> get props => [
        vehicles,
        exit,
        dimension,
        jammedVehicle,
      ];
}
