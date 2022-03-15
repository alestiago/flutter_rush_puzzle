// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rush_puzzle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RushPuzzle _$RushPuzzleFromJson(Map<String, dynamic> json) => RushPuzzle(
      difficulty: $enumDecode(_$PuzzleDifficultyEnumMap, json['difficulty']),
      jammedVehicleId: json['jammedVehicleId'] as String,
      vehicles: (json['vehicles'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Vehicle.fromJson(e as Map<String, dynamic>)),
      ),
      lastVehicleMoved: json['lastVehicleMoved'] == null
          ? null
          : Vehicle.fromJson(json['lastVehicleMoved'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RushPuzzleToJson(RushPuzzle instance) =>
    <String, dynamic>{
      'vehicles': instance.vehicles,
      'jammedVehicleId': instance.jammedVehicleId,
      'difficulty': _$PuzzleDifficultyEnumMap[instance.difficulty],
      'lastVehicleMoved': instance.lastVehicleMoved,
    };

const _$PuzzleDifficultyEnumMap = {
  PuzzleDifficulty.beginner: 'beginner',
  PuzzleDifficulty.intermediate: 'intermediate',
  PuzzleDifficulty.advanced: 'advanced',
  PuzzleDifficulty.expert: 'expert',
};
