import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final innerBorder = rect.tileSize * 6 + rect.tileSpace * 9.0;

    return ZGroup(
      sortMode: SortMode.update,
      children: [
        // Moves z-index very far
        ZPositioned(
          translate: const ZVector.only(z: -10000),
          child: ZShape(color: Colors.transparent, visible: false),
        ),
        ZGroup(
          sortMode: SortMode.update,
          children: [
            ZPositioned(
              translate: ZVector(0, 0, -rect.boardDepth / 2 - 0.5),
              child: ZRect(
                color: theme.boardInnerBackgroundColor!,
                height: innerBorder + rect.boardBorder * 2,
                fill: true,
                width: innerBorder + rect.boardBorder * 2,
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
        ZGroup(
          sortMode: SortMode.update,
          children: [
            for (final i in [-3, -2, -1, 1, 2, 3])
              for (final j in [-3, -2, -1, 1, 2, 3])
                ZPositioned(
                  translate: _translateMatrix(
                        i,
                        j,
                        rect.tileSize,
                        rect.tileSpace,
                      ) +
                      const ZVector.only(z: -2),
                  child: ZTile(
                    sideColor: theme.tileSideColor!,
                    color: theme.tileColor!,
                    size: rect.tileSize,
                    depth: rect.tileDepth,
                  ),
                ),
          ],
        ),
      ],
    );
  }

  ZVector _translateMatrix(int i, int j, double size, double space) {
    final double dx;
    if (i < 0) {
      dx = size * (i + 0.5) + space * (i + 0.5);
    } else {
      dx = size * (i - 0.5) + space * (i - 0.5);
    }
    final double dy;
    if (j < 0) {
      dy = size * (j + 0.5) + space * (j + 0.5);
    } else {
      dy = size * (j - 0.5) + space * (j - 0.5);
    }
    return ZVector(dx, dy, 0);
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
    final innerBorder = rect.tileSize * 6 + rect.tileSpace * 10.0;

    final side = ZGroup(
      children: [
        ZPositioned(
          translate: ZVector(
            innerBorder / 4,
            innerBorder / 2 + rect.boardBorder / 2,
            0,
          ),
          child: ZBox(
            width: innerBorder / 2,
            height: rect.boardBorder,
            depth: rect.boardDepth,
            color: theme.boardColor!,
            topColor: theme.boardInnerSideColor,
            bottomColor: theme.boardOutterSideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector(
            -innerBorder / 4,
            innerBorder / 2 + rect.boardBorder / 2,
            0,
          ),
          child: ZBox(
            width: innerBorder / 2,
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
            innerBorder / 2 + rect.boardBorder / 2,
            innerBorder / 2 + rect.boardBorder / 2,
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
            innerBorder / 2 + rect.boardBorder / 2,
            innerBorder / 4,
            0,
          ),
          child: ZBox(
            height: innerBorder / 2,
            width: rect.boardBorder,
            depth: rect.boardDepth,
            color: theme.boardColor!,
            leftColor: theme.boardInnerSideColor,
            rightColor: theme.boardOutterSideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector(
            innerBorder / 2 + rect.boardBorder / 2,
            -innerBorder / 4 - rect.tileSize / 2 - rect.tileSpace / 2,
            0,
          ),
          child: ZBox(
            height: innerBorder / 2 - rect.tileSize - rect.tileSpace,
            width: rect.boardBorder,
            depth: rect.boardDepth,
            color: theme.boardColor!,
            leftColor: theme.boardInnerSideColor,
            rightColor: theme.boardOutterSideColor,
          ),
        ),
        ZPositioned(
          translate: ZVector(
            innerBorder / 2 + rect.boardBorder / 2,
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
