import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_models/puzzle_models.dart';
import 'package:zcomponents/zcomponents.dart';

/// Board game
class ZBoard extends StatelessWidget {
  /// Board game
  const ZBoard({
    Key? key,
    required this.layout,
  }) : super(key: key);

  /// Rect of the game
  final GameLayout layout;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<BoardThemeData?>() ??
        BoardThemeData.fromMaterialColor(Colors.blue);

    return ZGroup(
      children: [
        _BoardBorders(theme: theme, layout: layout),
        _Board(theme: theme, layout: layout),
      ],
    );
  }
}

class _Board extends StatelessWidget {
  const _Board({
    Key? key,
    required this.theme,
    required this.layout,
  }) : super(key: key);

  final BoardThemeData theme;

  final GameLayout layout;

  @override
  Widget build(BuildContext context) {
    final size = layout.boardSize - layout.boardBorder * 2;

    return ZGroup(
      sortMode: SortMode.update,
      children: [
        // Moves z-index very far
        ZPositioned(
          translate: const ZVector.only(z: -10000),
          child: ZShape(color: Colors.transparent, visible: false),
        ),
        if (DebugGame.isDebugMode(context))
          ZPositioned(
            translate: layout.boardTopLeft + const ZVector.only(z: 5),
            child: ZGroup(
              children: [
                ZPositioned(
                  translate: layout.boundary.zMinPosition,
                  child: ZCircle(diameter: 1, color: Colors.red, stroke: 2),
                ),
                ZPositioned(
                  translate: layout.boundary.zMaxPosition,
                  child: ZCircle(diameter: 1, color: Colors.red, stroke: 2),
                ),
              ],
            ),
          ),
        ZGroup(
          sortMode: SortMode.update,
          children: [
            ZPositioned(
              translate: ZVector(0, 0, -layout.boardDepth / 2 - 0.5),
              child: ZRect(
                color: theme.boardInnerBackgroundColor!,
                height: size,
                fill: true,
                width: size,
                backfaceColor: theme.boardBackColor,
              ),
            ),
            ZPositioned(
              translate: const ZVector(0, 0, -10000),
              child: ZShape(
                color: Colors.transparent,
                visible: false,
              ),
            ),
          ],
        ),

        ZPositioned(
          translate: layout.boardTopLeft + const ZVector.only(z: -2),
          child: ZGroup(
            sortMode: SortMode.update,
            children: [
              for (final i in [0, 1, 2, 3, 4, 5])
                for (final j in [0, 1, 2, 3, 4, 5])
                  ZPositioned(
                    translate: _tileTranslation(Position(i, j), layout),
                    child: ZTile(
                      sideColor: theme.tileSideColor!,
                      color: theme.tileColor!,
                      size: layout.tileSize,
                      depth: layout.tileDepth,
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }

  ZVector _tileTranslation(Position position, GameLayout rect) {
    return rect.boxFor(position, 1, Steering.horizontal).zCenter;
  }
}

class _BoardBorders extends StatelessWidget {
  const _BoardBorders({
    Key? key,
    required this.theme,
    required this.layout,
  }) : super(key: key);

  final BoardThemeData theme;

  final GameLayout layout;

  @override
  Widget build(BuildContext context) {
    final length = layout.boardSize - layout.boardBorder * 2;
    final halfLength = length / 2;
    final quarterLength = length / 4;
    final halfBorder = layout.boardBorder / 2;

    final side = ZGroup(
      children: [
        ZPositioned(
          translate: ZVector(quarterLength, halfLength + halfBorder, 0),
          child: ZBox(
            width: halfLength,
            height: layout.boardBorder,
            depth: layout.boardDepth,
            color: theme.boardColor!,
            topColor: theme.boardInnerSideColor,
            bottomColor: theme.boardOutterSideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector(quarterLength, halfLength + halfBorder, 0),
          child: ZBox(
            width: halfLength,
            height: layout.boardBorder,
            depth: layout.boardDepth,
            color: theme.boardColor!,
            topColor: theme.boardInnerSideColor,
            bottomColor: theme.boardOutterSideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector(quarterLength, halfLength + halfBorder, 0),
          child: ZBox(
            width: halfLength,
            height: layout.boardBorder,
            depth: layout.boardDepth,
            color: theme.boardColor!,
            topColor: theme.boardInnerSideColor,
            bottomColor: theme.boardOutterSideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector(-quarterLength, halfLength + halfBorder, 0),
          child: ZBox(
            width: halfLength,
            height: layout.boardBorder,
            depth: layout.boardDepth,
            color: theme.boardColor!,
            topColor: theme.boardInnerSideColor,
            bottomColor: theme.boardOutterSideColor,
          ),
        ),
      ],
    );

    final corner = ZGroup(
      children: [
        ZPositioned(
          translate: ZVector(
            halfLength + halfBorder,
            halfLength + halfBorder,
            0,
          ),
          child: ZBox(
            width: layout.boardBorder,
            height: layout.boardBorder,
            depth: layout.boardDepth,
            color: theme.boardColor!,
            bottomColor: theme.boardOutterSideColor,
            rightColor: theme.boardOutterSideColor,
          ),
        )
      ],
    );

    return ZGroup(
      children: [
        // Corners
        corner,
        ZPositioned(
          rotate: const ZVector.only(z: pi / 2),
          child: corner,
        ),
        ZPositioned(
          rotate: const ZVector.only(z: pi),
          child: corner,
        ),
        ZPositioned(
          rotate: const ZVector.only(z: -pi / 2),
          child: corner,
        ),

        // bottom
        side,
        // top
        ZPositioned(
          rotate: const ZVector.only(z: pi),
          child: side,
        ),
        // Left
        ZPositioned(
          rotate: const ZVector.only(z: pi / 2),
          child: side,
        ),

        // Right
        ZPositioned(
          translate: ZVector(
            halfLength + layout.boardBorder / 2,
            quarterLength,
            0,
          ),
          child: ZBox(
            height: halfLength,
            width: layout.boardBorder,
            depth: layout.boardDepth,
            color: theme.boardColor!,
            leftColor: theme.boardInnerSideColor,
            rightColor: theme.boardOutterSideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector(
            halfLength + halfBorder,
            -quarterLength - layout.tileSize / 2 - layout.tileSpace / 2,
            0,
          ),
          child: ZBox(
            height: halfLength - layout.tileSize - layout.tileSpace,
            width: layout.boardBorder,
            depth: layout.boardDepth,
            color: theme.boardColor!,
            leftColor: theme.boardInnerSideColor,
            rightColor: theme.boardOutterSideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector(
            halfLength + halfBorder,
            -layout.tileSize / 2 - layout.tileSpace / 2,
            -layout.boardDepth / 2 + layout.tileDepth / 2,
          ),
          child: ZBox(
            height: layout.tileSize + layout.tileSpace,
            width: layout.boardBorder,
            depth: layout.tileDepth,
            color: theme.boardColor!,
            frontColor: theme.boardInnerBackgroundColor,
            leftColor: theme.boardInnerSideColor,
            rightColor: theme.boardOutterSideColor,
          ),
        ),
      ],
    );
  }
}
