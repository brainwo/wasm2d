import 'package:flutter/material.dart';
import 'dart:io';
import 'package:wasm/wasm.dart'; void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final data = File('../www/module.wasm').readAsBytesSync();
    final mod = WasmModule(data);

    return MaterialApp(
        title: 'WASM 2D',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Canvas")
          ),
          body: Center(
              child: CustomPaint(
            painter: WASMPainter(mod),
          )),
        ));
  }
}

class WASMPainter extends CustomPainter {
  const WASMPainter(this.mod);

  final WasmModule mod;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black
      ..isAntiAlias = true;

    var builder = mod.builder()
      ..addFunction('env', 'draw_line', (x1, y1, x2, y2) {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
      });

    debugPrint(mod.describe());

    canvas.drawColor(Colors.black, BlendMode.color);

    final inst = builder.build();
    final wasmMain = inst.lookupFunction("main");

    wasmMain(0, 0);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
