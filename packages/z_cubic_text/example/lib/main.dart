import 'package:example/example_strings.dart';
import 'package:flutter/material.dart';
import 'package:z_cubic_text/z_cubic_text.dart';
import 'package:zflutter/zflutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OverviewPage(),
    );
  }
}

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: exampleString.length,
        itemBuilder: (context, index) {
          return _ZTextExamplePage(exampleString[index]);
        },
      ),
    );
  }
}

class _ZTextExamplePage extends StatelessWidget {
  const _ZTextExamplePage(
    this.value, {
    Key? key,
  }) : super(key: key);

  final String value;

  void _onTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => this,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(value)),
      body: ZDragDetector(
        builder: (context, controller) {
          return GestureDetector(
            onTap: () => _onTap(context),
            child: ColoredBox(
              color: Colors.grey[100]!,
              child: ZIllustration(
                children: [
                  ZPositioned(
                    rotate: controller.rotate,
                    child: ZCubicText(value),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
