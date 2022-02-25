import 'package:equatable/equatable.dart';
import 'package:puzzle_models/puzzle_models.dart';

/// {@template driving_boundary}
/// Specifies from which [Position] to which [Position] the vehicle can move.
/// {@endtemplate}
class DrivingBoundary extends Equatable {
  /// {@macro driving_boundary}
  DrivingBoundary(this.from, this.to)
      : assert(from <= to, 'From must be smaller or equal to to.'),
        assert(
          from.x == to.x || from.y == to.y,
          'From and to must be on the same axis.',
        );

  /// The smallest [Position] the vehicle can move.
  final Position from;

  /// The greatest [Position] the vehicle can move.
  final Position to;

  /// Checks if a [Position] is within [from] and [to].
  bool contains(Position position) {
    return from <= position && position <= to;
  }

  @override
  List<Object?> get props => [from, to];
}
