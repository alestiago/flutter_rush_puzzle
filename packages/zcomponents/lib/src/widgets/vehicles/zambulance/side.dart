enum ZAmbulanceSide {
  right,
  left,
  rear,
  front,
}

extension ZAmbulanceSideX on ZAmbulanceSide {
  bool get isRight => this == ZAmbulanceSide.right;
  bool get isLeft => this == ZAmbulanceSide.left;
  bool get isRear => this == ZAmbulanceSide.rear;
}
