import 'package:equatable/equatable.dart';

/// {@template position}
/// 2-dimensional position model.
///
/// (0, 0) is the top left corner of the board.
/// {@endtemplate}
class Position extends Equatable {
  /// {@macro position}
  const Position(this.x, this.y)
      : assert(
          x >= 0,
          'x must be greater than or equal to 0.',
        ),
        assert(
          y >= 0,
          'y must be greater than or equal to 0.',
        );

  /// Linearly intepolates between two positions.
  factory Position.lerp(Position from, Position to, int x) {
    final differenceX = to.x - from.x;
    final gradient =
        differenceX != 0 ? (to.y - from.y) / (to.x - from.x) : differenceX;
    final y = from.y + gradient * (x - from.x);
    return Position(x, y.round());
  }

  /// The x position.
  final int x;

  /// The y position.
  final int y;

  /// Flips the x coordinate with the y coordinate.
  ///
  /// For example, (0, 1) becomes (1, 0).
  Position flip() => Position(y, x);

  /// Adds [Position] to this position.
  Position operator +(Position other) {
    return Position(x + other.x, y + other.y);
  }

  /// Subtracts [Position] to this position.
  Position operator -(Position other) {
    return Position(x - other.x, y - other.y);
  }

  /// Returns true if [Position] larger or equal in both directions.
  ///
  /// ```dart
  /// Position(1, 1) <= Position(1, 2) // true
  /// Position(1, 1) <= Position(0, 1) // false
  /// ```
  bool operator <=(Position other) {
    return x <= other.x && y <= other.y;
  }

  /// Returns true if [Position] smaller or equal in both directions.
  ///
  /// ```dart
  /// Position(1, 1) >= Position(1, 2) // false
  /// Position(1, 1) >= Position(0, 1) // true
  /// ```
  bool operator >=(Position other) {
    return x >= other.x && y >= other.y;
  }

  @override
  List<Object> get props => [x, y];
}
