// ignore_for_file: public_member_api_docs

enum ZVehicleSide {
  right,
  left,
  rear,
  front,
}

extension ZVehicleSideX on ZVehicleSide {
  bool get isSide => isRight || isLeft;
  bool get isRight => this == ZVehicleSide.right;
  bool get isLeft => this == ZVehicleSide.left;
  bool get isRear => this == ZVehicleSide.rear;
  bool get isFront => this == ZVehicleSide.front;
}
