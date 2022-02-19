import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// {@template debug_game}
/// A widget that marks the game as debug mode
///
/// If [debug] is true, a  box is painted around each vehicle bounds, and some
/// points to indicate the different bounds of the game
/// {@endtemplate}
class DebugGame extends StatelessWidget {
  /// {@macro debug_game}
  const DebugGame({
    Key? key,
    this.debug = true,
    required this.child,
  }) : super(key: key);

  /// Mark games are debug
  final bool debug;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Provider.value(value: _DebugGameData(debug: debug), child: child);
  }

  /// Checks if the current tree is marked as debug game
  static bool isDebugMode(BuildContext context, {bool listen = true}) {
    return Provider.of<_DebugGameData?>(context, listen: listen)?.debug ??
        false;
  }
}

class _DebugGameData extends Equatable {
  const _DebugGameData({required this.debug});

  final bool debug;

  @override
  List<Object?> get props => [debug];
}
