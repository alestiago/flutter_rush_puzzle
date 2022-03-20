import 'package:example/z_axis.dart';
import 'package:flutter/material.dart';
import 'package:zvehicles/zvehicles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehicles = [
      ZAmbulance(theme: AmbulanceThemeData.white),
      ZBus(theme: BusThemeData.school),
      ZCar(theme: CarThemeData.red)
    ];

    return MaterialApp(
      home: PageView(
        children: vehicles.map((v) => VehicleView(zchild: v)).toList(),
      ),
    );
  }
}

class VehicleView extends StatelessWidget {
  const VehicleView({
    Key? key,
    required this.zchild,
  }) : super(key: key);

  final Widget zchild;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200]!,
      body: Stack(
        children: [
          ZDragDetector(
            builder: ((context, controller) {
              return LayoutBuilder(builder: (context, constraints) {
                final rotate = controller.rotate;

                return Stack(
                  children: [
                    Positioned(
                      bottom: 50,
                      left: 50,
                      child: Text(
                          'x: ${rotate.x}\ny: ${rotate.y}\nz: ${rotate.z}'),
                    ),
                    ZIllustration(
                      children: [
                        ZPositioned(
                          scale: const ZVector.all(3),
                          rotate: rotate,
                          child: ZGroup(
                            children: [zchild, const ZAxis()],
                          ),
                        )
                      ],
                    ),
                  ],
                );
              });
            }),
          ),
        ],
      ),
    );
  }
}
