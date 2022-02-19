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
    required this.rect,
  }) : super(key: key);

  /// Rect of the game
  final GameRect rect;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<BoardThemeData?>() ??
        BoardThemeData.fromMaterialColor(Colors.blue);

    return ZGroup(
      children: [
        _BoardBorders(theme: theme, rect: rect),
        _Board(theme: theme, rect: rect),
      ],
    );
  }
}

class _Board extends StatelessWidget {
  const _Board({
    Key? key,
    required this.theme,
    required this.rect,
  }) : super(key: key);

  final BoardThemeData theme;

  final GameRect rect;

  @override
  Widget build(BuildContext context) {
    final size = rect.boardSize - rect.boardBorder * 2;

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
            translate: game.boardTopLeft + const ZVector.only(z: 5),
            child: ZGroup(
              children: [
                ZPositioned(
                  translate: game.board.zMinPosition,
                  child: ZCircle(diameter: 1, color: Colors.red, stroke: 2),
                ),
                ZPositioned(
                  translate: game.board.zMaxPosition,
                  child: ZCircle(diameter: 1, color: Colors.red, stroke: 2),
                ),
              ],
            ),
          ),
        ZGroup(
          sortMode: SortMode.update,
          children: [
            ZPositioned(
              translate: ZVector(0, 0, -rect.boardDepth / 2 - 0.5),
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
          translate: rect.boardTopLeft + const ZVector.only(z: -2),
          child: ZGroup(
            sortMode: SortMode.update,
            children: [
              for (final i in [0, 1, 2, 3, 4, 5])
                for (final j in [0, 1, 2, 3, 4, 5])
                  ZPositioned(
                    translate: _tileTranslation(Position(i, j), rect),
                    child: ZTile(
                      sideColor: theme.tileSideColor!,
                      color: theme.tileColor!,
                      size: rect.tileSize,
                      depth: rect.tileDepth,
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }

  ZVector _tileTranslation(Position position, GameRect rect) {
    return rect.boxFor(position, 1, Steering.horizonal).zCenter;
  }
}

class _BoardBorders extends StatelessWidget {
  const _BoardBorders({
    Key? key,
    required this.theme,
    required this.rect,
  }) : super(key: key);

  final BoardThemeData theme;

  final GameRect rect;

  @override
  Widget build(BuildContext context) {
    final length = rect.boardSize - rect.boardBorder * 2;
    final halfLength = length / 2;
    final quarterLength = length / 4;
    final halfBorder = rect.boardBorder / 2;

    final side = ZGroup(
      children: [
        ZPositioned(
          translate: ZVector(quarterLength, halfLength + halfBorder, 0),
          child: ZBox(
            width: halfLength,
            height: rect.boardBorder,
            depth: rect.boardDepth,
            color: theme.boardColor!,
            topColor: theme.boardInnerSideColor,
            bottomColor: theme.boardOutterSideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector(-quarterLength, halfLength + halfBorder, 0),
          child: ZBox(
            width: halfLength,
            height: rect.boardBorder,
            depth: rect.boardDepth,
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
            width: rect.boardBorder,
            height: rect.boardBorder,
            depth: rect.boardDepth,
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
            halfLength + rect.boardBorder / 2,
            quarterLength,
            0,
          ),
          child: ZBox(
            height: halfLength,
            width: rect.boardBorder,
            depth: rect.boardDepth,
            color: theme.boardColor!,
            leftColor: theme.boardInnerSideColor,
            rightColor: theme.boardOutterSideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector(
            halfLength + halfBorder,
            -quarterLength - rect.tileSize / 2 - rect.tileSpace / 2,
            0,
          ),
          child: ZBox(
            height: halfLength - rect.tileSize - rect.tileSpace,
            width: rect.boardBorder,
            depth: rect.boardDepth,
            color: theme.boardColor!,
            leftColor: theme.boardInnerSideColor,
            rightColor: theme.boardOutterSideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector(
            halfLength + halfBorder,
            -rect.tileSize / 2 - rect.tileSpace / 2,
            -rect.boardDepth / 2 + rect.tileDepth / 2,
          ),
          child: ZBox(
            height: rect.tileSize + rect.tileSpace,
            width: rect.boardBorder,
            depth: rect.tileDepth,
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
