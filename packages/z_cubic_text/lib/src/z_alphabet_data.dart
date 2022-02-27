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
    'B': [[], [], []],
    'C': [[], [], []],
    'D': [[], [], []],
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
    'F': [[], [], []],
    'G': [[], [], []],
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
    'I': [[], [], []],
    'J': [[], [], []],
    'K': [[], [], []],
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
    'M': [[], [], []],
    'N': [[], [], []],
    'O': [[], [], []],
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
    'Q': [[], [], []],
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
    'T': [[], [], []],
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
    'W': [[], [], []],
    'X': [[], [], []],
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
  };
}
