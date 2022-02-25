// TODO(alestiago): remove this file.

part of 'puzzle_page.dart';

final _vehicles = [
  Vehicle(
    id: 'A',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(0, 0),
  ),
  Vehicle(
    id: 'B',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(1, 0),
  ),
  Vehicle(
    id: 'C',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(2, 0),
  ),
  Vehicle(
    id: 'D',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(3, 0),
  ),
  Vehicle(
    id: 'E',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(4, 0),
  ),
  Vehicle(
    id: 'F',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(5, 0),
  ),
  Vehicle(
    id: 'G',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(0, 2),
  ),
  Vehicle(
    id: 'H',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(1, 2),
  ),
  Vehicle(
    id: 'I',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(2, 2),
  ),
  Vehicle(
    id: 'J',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(3, 2),
  ),
  Vehicle(
    id: 'K',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(4, 2),
  ),
  Vehicle(
    id: 'L',
    length: 2,
    steering: Steering.vertical,
    firstPosition: const Position(5, 2),
  ),
  Vehicle(
    id: 'M',
    length: 3,
    steering: Steering.horizonal,
    firstPosition: const Position(0, 4),
  ),
  // Vehicle(
  //   id: 'N',
  //   length: 3,
  //   steering: Steering.horizonal,
  //   firstPosition: const Position(3, 4),
  // ),
  Vehicle(
    id: 'O',
    length: 3,
    steering: Steering.horizonal,
    firstPosition: const Position(0, 5),
  ),
  // Vehicle(
  //   id: 'P',
  //   length: 3,
  //   steering: Steering.horizonal,
  //   firstPosition: const Position(3, 5),
  // ),
];

final _puzzle = RushPuzzle(
  exit: const Position(6, 3),
  jammedVehicle: _vehicles.first,
  dimension: const Position(6, 6),
  vehicles: Map.fromEntries(_vehicles.map((e) => MapEntry(e.id, e))),
);
