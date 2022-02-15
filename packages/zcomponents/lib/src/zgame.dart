import 'package:flutter/material.dart';
import 'package:zcomponents/src/vehicles/zcar2.dart';
import 'package:zcomponents/zcomponents.dart';

final GameRect game = GameRect(tileSize: 30, tileSpace: 10);

class ZGame extends StatelessWidget {
  const ZGame({
    Key? key,
    required this.theme,
    this.transform,
  }) : super(key: key);

  final BoardThemeData theme;
  final ZTransform? transform;

  @override
  Widget build(BuildContext context) {
    return AnimatedBoardTheme(
      data: theme,
      child: TweenAnimationBuilder<ZTransform?>(
        tween: ZTransformTween(
          begin: transform,
          end: transform,
        ),
        duration: const Duration(milliseconds: 600),
        builder: (_, animatedTransform, __) => ZDragDetector(
          builder: (context, controller) {
            final transform = animatedTransform ?? ZTransform();
            return Align(
              child: ZIllustration(
                children: [
                  ZPositioned(
                    rotate: transform.rotate,
                    scale: transform.scale,
                    translate: transform.translate,
                    child: ZPositioned(
                      rotate: controller.value,
                      child: ZGroup(
                        children: [
                          ZBoard(
                            rect: game,
                          ),
                          ZPositioned(
                            translate: game.boardTopLeft,
                            child: ZGroup(
                              children: [
                                ZVehicleController(
                                  length: 2,
                                  offset: const TileOffset(0, 0),
                                  axis: Axis.vertical,
                                  child: ZCar2(
                                    sideColor: Colors.green[700]!,
                                    topColor: Colors.green[600],
                                  ),
                                ),
                                ZVehicleController(
                                  length: 2,
                                  offset: const TileOffset(1, 0),
                                  axis: Axis.vertical,
                                  child: ZCar2(
                                    sideColor: Colors.grey[900]!,
                                    topColor: Colors.grey[800],
                                    doorSideColor: Colors.grey[100],
                                    topMiddleColor: Colors.grey[100],
                                    topBoxColor: Colors.red,
                                  ),
                                ),
                                ZVehicleController(
                                  length: 2,
                                  offset: const TileOffset(2, 0),
                                  axis: Axis.vertical,
                                  child: ZCar2(
                                    sideColor: Colors.green[700]!,
                                    topColor: Colors.green[600],
                                  ),
                                ),
                                ZVehicleController(
                                  length: 2,
                                  offset: const TileOffset(3, 0),
                                  axis: Axis.vertical,
                                  child: ZCar2(
                                    sideColor: Colors.green[700]!,
                                    topColor: Colors.green[600],
                                  ),
                                ),
                                ZVehicleController(
                                  length: 2,
                                  offset: const TileOffset(4, 0),
                                  axis: Axis.vertical,
                                  child: ZCar2(
                                    sideColor: Colors.green[700]!,
                                    topColor: Colors.green[600],
                                  ),
                                ),
                                ZVehicleController(
                                  length: 2,
                                  offset: const TileOffset(5, 0),
                                  axis: Axis.vertical,
                                  child: ZCar2(
                                    sideColor: Colors.green[700]!,
                                    topColor: Colors.green[600],
                                  ),
                                ),
                                ZVehicleController(
                                  length: 2,
                                  offset: const TileOffset(0, 2),
                                  axis: Axis.vertical,
                                  child: ZCar2(
                                    sideColor: Colors.green[700]!,
                                    topColor: Colors.green[600],
                                  ),
                                ),
                                ZVehicleController(
                                  length: 2,
                                  offset: const TileOffset(1, 2),
                                  axis: Axis.vertical,
                                  child: ZCar2(
                                    sideColor: Colors.grey[900]!,
                                    topColor: Colors.grey[800],
                                    doorSideColor: Colors.grey[100],
                                  ),
                                ),
                                ZVehicleController(
                                  length: 2,
                                  offset: const TileOffset(2, 2),
                                  axis: Axis.vertical,
                                  child: ZCar2(
                                    sideColor: Colors.green[700]!,
                                    topColor: Colors.green[600],
                                  ),
                                ),
                                ZVehicleController(
                                  length: 2,
                                  offset: const TileOffset(3, 2),
                                  axis: Axis.vertical,
                                  child: ZCar2(
                                    sideColor: Colors.green[700]!,
                                    topColor: Colors.green[600],
                                  ),
                                ),
                                ZVehicleController(
                                  length: 2,
                                  offset: const TileOffset(4, 2),
                                  axis: Axis.vertical,
                                  child: ZCar2(
                                    sideColor: Colors.green[700]!,
                                    topColor: Colors.green[600],
                                  ),
                                ),
                                ZVehicleController(
                                  length: 2,
                                  offset: const TileOffset(5, 2),
                                  axis: Axis.vertical,
                                  child: ZCar2(
                                    sideColor: Colors.green[700]!,
                                    topColor: Colors.green[600],
                                  ),
                                ),
                                const ZVehicleController(
                                  length: 3,
                                  offset: TileOffset(0, 5),
                                  axis: Axis.horizontal,
                                  child: ZBus(),
                                ),
                                const ZVehicleController(
                                  length: 3,
                                  offset: TileOffset(0, 4),
                                  axis: Axis.horizontal,
                                  child: ZBus(),
                                ),
                                const ZVehicleController(
                                  length: 3,
                                  offset: TileOffset(3, 5),
                                  axis: Axis.horizontal,
                                  child: ZBus(),
                                ),
                                const ZVehicleController(
                                  length: 3,
                                  offset: TileOffset(3, 4),
                                  axis: Axis.horizontal,
                                  child: ZBus(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ZTransformTween extends Tween<ZTransform?> {
  /// Creates a [Color] tween.
  ///
  /// The [begin] and [end] properties may be null; the null value
  /// is treated as transparent.
  ///
  /// We recommend that you do not pass [Colors.transparent] as [begin]
  /// or [end] if you want the effect of fading in or out of transparent.
  /// Instead prefer null. [Colors.transparent] refers to black transparent and
  /// thus will fade out of or into black which is likely unwanted.
  ZTransformTween({ZTransform? begin, ZTransform? end})
      : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  ZTransform? lerp(double t) {
    return ZTransform(
      rotate: ZVector.lerp(begin!.rotate, end?.rotate, t),
      translate: ZVector.lerp(begin!.translate, end?.translate, t),
      scale: ZVector.lerp(begin!.scale, end?.scale, t),
    );
  }
}
