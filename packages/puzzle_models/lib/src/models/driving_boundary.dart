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

  /// [Position]s that are inside the line defined by [from] and [to].
  List<Position> bounds() {
    assert(
      from.x == to.x || from.y == to.y,
      'From and to must be on the same axis.',
    );

    final isHorizontal = from.y == to.y;
    if (!isHorizontal) {
      final bounds = DrivingBoundary(from.flip(), to.flip()).bounds();
      return bounds.map((position) => position.flip()).toList();
    } else {
      final positions = <Position>[];
      for (var x = from.x; x <= to.x; x++) {
        final newPosition = Position.lerp(from, to, x);
        positions.add(newPosition);
      }
      return positions;
    }
  }

  @override
  List<Object?> get props => [from, to];
}
