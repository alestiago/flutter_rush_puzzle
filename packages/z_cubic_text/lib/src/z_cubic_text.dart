import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:z_cubic_text/src/z_char.dart';
import 'package:z_cubic_text/src/z_cubic_text_style.dart';
import 'package:zflutter/zflutter.dart';

class ZCubicText extends StatelessWidget {
  const ZCubicText(
    this.text, {
    Key? key,
    this.style = const ZCubicTextStyle(),
  }) : super(key: key);

  final String text;
  final ZCubicTextStyle style;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    var currentPos = ZVector.zero;
    final spaceWidth = style.fontSize;

    for (var i = 0; i < text.length; i++) {
      final char = text[i];
      if (char == '\n') {
        currentPos = ZVector.only(y: style.fontSize * 4);
        continue;
      }

      final zchar = ZChar(
        char,
        style: style,
      );

      children.add(
        ZPositioned(
          translate: currentPos,
          child: zchar,
        ),
      );
      currentPos += ZVector.only(x: zchar.width + spaceWidth);
    }

    return Provider<ZCubicTextStyle>.value(
      value: style,
      child: ZGroup(children: children),
    );
  }
}
