import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Animated board theme which automatically transitions the colors,
/// etc, over a given duration whenever the given theme changes.
class AnimatedBoardTheme extends StatelessWidget {
  /// Animated board theme
  const AnimatedBoardTheme({
    Key? key,
    required this.data,
    required this.child,
    this.duration = kThemeAnimationDuration,
  }) : super(key: key);

  /// Specifies the color values for descendant widgets.
  final BoardThemeData data;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  /// The duration over which to animate the parameters.
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<BoardThemeData?>(
      tween: BoardThemeTween(
        begin: data,
        end: data,
      ),
      duration: duration,
      builder: (context, value, child) {
        return Provider<BoardThemeData>.value(
          value: value!,
          child: child,
        );
      },
      child: child,
    );
  }
}

/// Defines the configuration of the overall visual [AnimatedBoardTheme] for a
/// a widget subtree within the app.
class BoardThemeData extends Equatable {
  /// Create a [BoardThemeData] that's used to configure a [AnimatedBoardTheme].
  const BoardThemeData({
    required this.tileColor,
    required this.tileSideColor,
    required this.boardColor,
    required this.boardInnerSideColor,
    required this.boardInnerBackgroundColor,
    required this.boardOutterSideColor,
    required this.boardBackColor,
    required this.backgroundColor,
    required this.shadowColor,
  });

  /// Generate a [BoardThemeData] from a given [MaterialColor]
  factory BoardThemeData.fromMaterialColor(MaterialColor color) {
    return BoardThemeData(
      tileColor: color[200],
      tileSideColor: color[300],
      boardColor: color[200],
      boardInnerSideColor: color[300],
      boardInnerBackgroundColor: color[400],
      boardOutterSideColor: color[300],
      boardBackColor: color[500],
      backgroundColor: color[100],
      shadowColor: color[500]!.withOpacity(0.15),
    );
  }

  /// Color of the tile
  final Color? tileColor;

  /// Color of the tile sides
  final Color? tileSideColor;

  /// Main color for the board
  final Color? boardColor;

  ///  Color for the back of the board
  final Color? boardBackColor;

  /// Color for the inner sides of the board
  final Color? boardInnerSideColor;

  /// Color for the inner background of the board
  final Color? boardInnerBackgroundColor;

  /// Color for the outter sides of the board
  final Color? boardOutterSideColor;

  /// Background color for the canvas
  final Color? backgroundColor;

  /// Shadow color for the canvas
  final Color? shadowColor;

  /// Linearly interpolate between two board themes.
  ///
  /// The arguments must not be null.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static BoardThemeData? lerp(BoardThemeData? a, BoardThemeData? b, double t) {
    return BoardThemeData(
      tileColor: Color.lerp(a?.tileColor, b?.tileColor, t),
      tileSideColor: Color.lerp(a?.tileSideColor, b?.tileSideColor, t),
      boardColor: Color.lerp(a?.boardColor, b?.boardColor, t),
      boardInnerSideColor: Color.lerp(
        a?.boardInnerSideColor,
        b?.boardInnerSideColor,
        t,
      ),
      boardInnerBackgroundColor: Color.lerp(
        a?.boardInnerBackgroundColor,
        b?.boardInnerBackgroundColor,
        t,
      ),
      boardOutterSideColor: Color.lerp(
        a?.boardOutterSideColor,
        b?.boardOutterSideColor,
        t,
      ),
      boardBackColor: Color.lerp(a?.boardBackColor, b?.boardBackColor, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      shadowColor: Color.lerp(a?.shadowColor, b?.shadowColor, t),
    );
  }

  @override
  List<Object?> get props => [
        tileColor,
        tileSideColor,
        boardColor,
        boardInnerSideColor,
        boardInnerBackgroundColor,
        boardOutterSideColor,
        boardBackColor,
        backgroundColor,
        shadowColor,
      ];
}

/// A [BoardThemeData] tween.

class BoardThemeTween extends Tween<BoardThemeData?> {
  /// Creates a [BoardThemeData] tween.
  BoardThemeTween({BoardThemeData? begin, BoardThemeData? end})
      : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  BoardThemeData? lerp(double t) => BoardThemeData.lerp(begin, end, t);
}
