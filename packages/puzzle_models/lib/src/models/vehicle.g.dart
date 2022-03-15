// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      id: json['id'] as String,
      steering: $enumDecode(_$SteeringEnumMap, json['steering']),
      firstPosition:
          Position.fromJson(json['firstPosition'] as Map<String, dynamic>),
      type: $enumDecode(_$VehicleTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$VehicleTypeEnumMap[instance.type],
      'steering': _$SteeringEnumMap[instance.steering],
      'firstPosition': instance.firstPosition,
    };

const _$SteeringEnumMap = {
  Steering.horizontal: 'horizontal',
  Steering.vertical: 'vertical',
};

const _$VehicleTypeEnumMap = {
  VehicleType.taxi: 'taxi',
  VehicleType.car: 'car',
  VehicleType.police: 'police',
  VehicleType.bus: 'bus',
  VehicleType.secondaryBus: 'secondaryBus',
  VehicleType.truck: 'truck',
  VehicleType.secondaryTruck: 'secondaryTruck',
  VehicleType.ambulance: 'ambulance',
};
