import 'package:flutter/widgets.dart';
import 'package:zcomponents/zcomponents.dart';

class ZPositionTracker extends ZPositioned implements Widget {
  const ZPositionTracker({
    Key? key,
    this.onTransform,
    required Widget child,
  }) : super(key: key, child: child);

  final void Function(List<ZTransform>)? onTransform;
  @override
  void updateParentData(
    RenderObject renderObject,
    ZPositioned oldWidget,
    ZTransform transform,
  ) {
    super.updateParentData(renderObject, oldWidget, transform);
    final parentData = renderObject.parentData as ZParentData;
    onTransform?.call(
      parentData.transforms.takeWhile((value) => value != transform).toList(),
    );
  }

  @override
  Type get debugTypicalAncestorWidgetClass => ZWidget;

  @override
  void startParentData(RenderObject renderObject, ZTransform transform) {
    assert(
      renderObject.parentData is ZParentData,
      'ZTrackPosition should only be used with ZWidgets',
    );
    final parentData = renderObject.parentData as ZParentData;
    onTransform?.call(
      parentData.transforms.takeWhile((value) => value != transform).toList(),
    );
    super.startParentData(renderObject, transform);
  }
}
