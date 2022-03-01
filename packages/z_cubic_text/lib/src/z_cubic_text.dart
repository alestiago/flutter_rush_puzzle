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
    if (text.isEmpty) return ZGroup(children: const []);

    final children = <Widget>[];
    var currentPos = ZVector.zero;

    late final double initialLetterWidth;
    for (var i = 0; i < text.length; i++) {
      final zchar = ZChar(
        text[i].toUpperCase(),
        style: style,
      );
      if (i == 0) initialLetterWidth = zchar.width;

      children.add(
        ZPositioned(
          translate: currentPos,
          child: zchar,
        ),
      );
      currentPos += ZVector.only(x: zchar.width + style.letterSpacing);
    }

    currentPos -= ZVector.only(x: style.letterSpacing);
    return Provider<ZCubicTextStyle>.value(
      value: style,
      child: ZPositioned(
        translate: ZVector.only(
          x: -currentPos.x / 2 + (initialLetterWidth / 2),
        ),
        child: ZGroup(children: children),
      ),
    );
  }
}
