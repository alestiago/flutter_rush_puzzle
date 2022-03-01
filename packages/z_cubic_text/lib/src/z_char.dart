import 'package:flutter/material.dart';
import 'package:z_cubic_text/src/z_alphabet_data.dart';
import 'package:z_cubic_text/z_cubic_text.dart';
import 'package:zflutter/zflutter.dart';

class ZChar extends StatelessWidget {
  ZChar(
    this.value, {
    Key? key,
    required this.style,
  })  : assert(value.length == 1, 'String can only have one character'),
        assert(
          ZAlphabetData.data.containsKey(value),
          'There is no matching character in alphabet',
        ),
        _def = ZAlphabetData.data[value]!,
        super(key: key);

  final String value;
  final ZLetterDef _def;
  final ZCubicTextStyle style;

  double get width => _def.length * style.fontSize;

  // TODO(alestiago): Take longest sublist length.
  double get height => _def[0].length * style.fontSize;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    var currentPos = ZVector.only(
      x: style.fontSize / 2,
      y: style.fontSize / 2,
    );

    final horizontalMovement = ZVector.only(x: style.fontSize);
    final verticalMovement = ZVector.only(y: style.fontSize);

    for (var row = 0; row < _def.length; row++) {
      final zrow = _def[row];
      for (var col = 0; col < zrow.length; col++) {
        final zchild = zrow[col];

        if (zchild != null) {
          children.add(
            ZPositioned(
              translate: currentPos,
              child: zchild,
            ),
          );
        }

        currentPos += horizontalMovement;
      }

      currentPos = ZVector.only(
        x: style.fontSize / 2,
        y: verticalMovement.y * (row.toDouble() + 1) + style.fontSize / 2,
      );
    }

    return ZPositioned(
      translate: ZVector.only(
        x: -width / 2,
        y: -height / 2,
      ),
      child: ZGroup(
        children: children,
      ),
    );
  }
}
