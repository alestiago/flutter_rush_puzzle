import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vMath;
import 'package:zcomponents/zcomponents.dart';
import 'package:zflutter/zflutter.dart';

class ZUtils {
  static Matrix4 matrixFromTransformations(List<ZTransform> transforms) {
    final matrix = Matrix4.translationValues(0, 0, 0);
    for (final transform in transforms) {
      final matrix4 = Matrix4.translationValues(
        transform.translate.x,
        transform.translate.y,
        transform.translate.z,
      )
        ..rotateX(transform.rotate.x)
        ..rotateY(-transform.rotate.y)
        ..rotateZ(transform.rotate.z)
        ..scale(
          transform.scale.x,
          transform.scale.y,
          transform.scale.z,
        );
      matrix.multiply(matrix4);
    }
    return matrix;
  }
}
