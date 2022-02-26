import 'package:flutter/material.dart';

class OverlayBarrier extends StatelessWidget {
  const OverlayBarrier({Key? key, this.visible = true}) : super(key: key);

  final bool visible;

  @override
  Widget build(BuildContext context) {
    final color = visible ? Colors.black54 : Colors.black.withOpacity(0);
    return IgnorePointer(
      ignoring: !visible,
      child: TweenAnimationBuilder<Color?>(
        tween: ColorTween(begin: Colors.black.withOpacity(0), end: color),
        duration: const Duration(milliseconds: 400),
        builder: (context, value, child) {
          return Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(color: value),
            child: child,
          );
        },
      ),
    );
  }
}
