import 'package:flutter/widgets.dart';
import 'package:zcomponents/zcomponents.dart';

Matrix4 matrixFromTransformations(List<ZTransform> transforms) {
  final matrix = Matrix4.identity();
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
