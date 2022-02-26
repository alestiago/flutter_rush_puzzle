import 'package:fireworks/fireworks.dart' as fireworks;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Fireworks extends StatefulWidget {
  const Fireworks({Key? key}) : super(key: key);

  @override
  State<Fireworks> createState() => _FireworksState();
}

class _FireworksState extends State<Fireworks>
    with SingleTickerProviderStateMixin {
  late final controller = fireworks.FireworkController(vsync: this);

  @override
  void initState() {
    controller
      ..start()
      ..autoLaunchDuration = const Duration(milliseconds: 800);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return fireworks.Fireworks(
      controller: controller,
    );
  }
}
