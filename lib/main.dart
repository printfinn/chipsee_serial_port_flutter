import 'package:flutter/material.dart';
import 'package:serial_app/serial_screen.dart';

void main() {
  runApp(const MySerialApp());
}

class MySerialApp extends StatelessWidget {
  const MySerialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SerialScreen(),
    );
  }
}
