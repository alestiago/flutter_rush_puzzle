import 'package:flutter/widgets.dart';
import 'package:z_cubic_text/src/shapes/shapes.dart';

typedef ZLetterDef = List<List<Widget?>>;

class ZAlphabetData {
  static const Map<String, ZLetterDef> data = {
    'A': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZCube(),
      ],
      [
        ZCube(),
        null,
        ZCube(),
      ],
    ],
    'B': [
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
    ],
    'C': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZCube(),
        null,
        null,
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.topRight),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
    ],
    'D': [
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZCube(),
        null,
        ZCube(),
      ],
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
    ],
    'E': [
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.top),
        ZSlab(orientation: ZSlabOrientation.top),
      ],
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.bottom),
        null,
      ],
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZSlab(orientation: ZSlabOrientation.bottom),
      ],
    ],
    'F': [
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.top),
        ZSlab(orientation: ZSlabOrientation.top),
      ],
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.bottom),
        null,
      ],
      [
        ZCube(),
        null,
        null,
      ],
    ],
    'G': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZCube(),
        null,
        ZSlab(orientation: ZSlabOrientation.bottom),
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.topRight),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZCube(),
      ],
    ],
    'H': [
      [
        ZCube(),
        null,
        ZCube(),
      ],
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZCube(),
      ],
      [
        ZCube(),
        null,
        ZCube(),
      ]
    ],
    'I': [
      [
        ZSlab(orientation: ZSlabOrientation.top),
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.top),
      ],
      [
        null,
        ZCube(),
        null,
      ],
      [
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.bottom),
      ],
    ],
    'J': [
      [
        null,
        null,
        ZCube(),
      ],
      [
        null,
        null,
        ZCube(),
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.topRight),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
    ],
    'K': [
      [
        ZCube(),
        null,
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
      ],
      [
        ZCube(),
        ZCube(),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
      [
        ZCube(),
        null,
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
    ],
    'L': [
      [
        ZCube(),
        null,
        null,
      ],
      [
        ZCube(),
        null,
        null,
      ],
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZSlab(orientation: ZSlabOrientation.bottom),
      ],
    ],
    'M': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
        null,
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
      ],
      [
        ZCube(),
        ZCube(),
        ZCube(),
      ],
      [
        ZCube(),
        null,
        ZCube(),
      ],
    ],
    'N': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
        null,
        ZCube(),
      ],
      [
        ZCube(),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
        ZCube(),
      ],
      [
        ZCube(),
        null,
        ZLShape(orientation: ZLShapeOrientation.topRight),
      ],
    ],
    'O': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZCube(),
        null,
        ZCube(),
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.topRight),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
    ],
    'P': [
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.top),
        ZCube(),
      ],
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZCube(),
      ],
      [
        ZCube(),
        null,
        null,
      ],
    ],
    'Q': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZCube(),
        null,
        ZCube(),
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.topRight),
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZCube(),
      ],
    ],
    'R': [
      [
        ZCube(),
        ZCube(),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZCube(),
        null,
        ZCube(),
      ],
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
    ],
    'S': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZSlab(orientation: ZSlabOrientation.top),
      ],
      [
        null,
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
    ],
    'T': [
      [
        ZSlab(orientation: ZSlabOrientation.top),
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.top),
      ],
      [
        null,
        ZCube(),
        null,
      ],
      [
        null,
        ZCube(),
        null,
      ],
    ],
    'U': [
      [
        ZCube(),
        null,
        ZCube(),
      ],
      [
        ZCube(),
        null,
        ZCube(),
      ],
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZCube(),
      ],
    ],
    'V': [
      [
        ZCube(),
        null,
        ZCube(),
      ],
      [
        ZCube(),
        null,
        ZCube(),
      ],
      [
        ZSlab(orientation: ZSlabOrientation.top),
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.top),
      ],
    ],
    'W': [
      [
        ZCube(),
        null,
        ZCube(),
      ],
      [
        ZCube(),
        ZCube(),
        ZCube(),
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.topRight),
        null,
        ZLShape(orientation: ZLShapeOrientation.topLeft)
      ],
    ],
    'X': [
      [
        ZLShape(orientation: ZLShapeOrientation.topRight),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
      [
        null,
        ZCube(),
        null,
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
    ],
    'Y': [
      [
        ZCube(),
        null,
        ZCube(),
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.topRight),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
      [
        null,
        ZCube(),
        null,
      ],
    ],
    'Z': [
      [
        ZSlab(orientation: ZSlabOrientation.top),
        ZSlab(orientation: ZSlabOrientation.top),
        ZCube(),
      ],
      [
        null,
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.bottom),
      ],
    ],
    ' ': [
      [null, null],
      [null, null],
      [null, null],
    ],
    '0': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZCube(),
        null,
        ZCube(),
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.topRight),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
    ],
    '1': [
      [
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZCube(),
        null,
      ],
      [
        null,
        ZCube(),
        null,
      ],
      [
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.bottom),
      ],
    ],
    '2': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        null,
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZSlab(orientation: ZSlabOrientation.bottom),
      ],
    ],
    '3': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        null,
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZSlab(orientation: ZSlabOrientation.top),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
    ],
    '4': [
      [
        ZCube(),
        null,
        ZCube(),
      ],
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZCube(),
      ],
      [
        null,
        null,
        ZCube(),
      ],
    ],
    '5': [
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.top),
        ZSlab(orientation: ZSlabOrientation.top),
      ],
      [
        ZSlab(orientation: ZSlabOrientation.top),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.topRight),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
    ],
    '6': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZSlab(orientation: ZSlabOrientation.top),
      ],
      [
        ZCube(),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.topRight),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
    ],
    '7': [
      [
        ZSlab(orientation: ZSlabOrientation.top),
        ZSlab(orientation: ZSlabOrientation.top),
        ZCube(),
      ],
      [
        null,
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
      [
        null,
        ZCube(),
        null,
      ],
    ],
    '8': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.topRight),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
    ],
    '9': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        ZLShape(orientation: ZLShapeOrientation.topRight),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZCube(),
      ],
      [
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
    ],
    '!': [
      [
        null,
        ZCube(),
        null,
      ],
      [
        null,
        ZCube(),
        null,
      ],
      [
        null,
        ZSlab(orientation: ZSlabOrientation.bottom),
        null,
      ],
    ],
    '?': [
      [
        ZLShape(orientation: ZLShapeOrientation.bottomRight),
        ZSlab(orientation: ZSlabOrientation.top),
        ZLShape(orientation: ZLShapeOrientation.bottomLeft),
      ],
      [
        null,
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZLShape(orientation: ZLShapeOrientation.topLeft),
      ],
      [
        null,
        ZSlab(orientation: ZSlabOrientation.bottom),
        null,
      ],
    ],
    ':': [
      [
        null,
        ZCube(),
        null,
      ],
      [
        null,
        null,
        null,
      ],
      [
        null,
        ZCube(),
        null,
      ],
    ],
    ';': [
      [
        null,
        ZCube(),
        null,
      ],
      [
        null,
        null,
        null,
      ],
      [
        null,
        ZLShape(orientation: ZLShapeOrientation.topRight),
        null,
      ],
    ],
    '.': [
      [
        null,
        null,
        null,
      ],
      [
        null,
        null,
        null,
      ],
      [
        null,
        ZCube(),
        null,
      ],
    ],
    ',': [
      [
        null,
        null,
        null,
      ],
      [
        null,
        null,
        null,
      ],
      [
        null,
        ZLShape(orientation: ZLShapeOrientation.topRight),
        null,
      ],
    ],
    '-': [
      [
        null,
        null,
        null,
      ],
      [
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZSlab(orientation: ZSlabOrientation.bottom),
        ZSlab(orientation: ZSlabOrientation.bottom),
      ],
      [
        null,
        null,
        null,
      ]
    ],
  };
}
