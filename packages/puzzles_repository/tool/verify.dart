// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:puzzle_models/puzzle_models.dart';


Future<void> main() async {
  final string = File('assets/1.json').readAsStringSync();

  final json = jsonDecode(string) as Map<String, dynamic>;
  final puzzle = RushPuzzle.fromJson(json);
  inspect(puzzle.toJson());
}
