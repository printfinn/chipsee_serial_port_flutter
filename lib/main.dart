import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

void main() {
  runApp(const MySerialApp());
}

class MySerialApp extends StatelessWidget {
  const MySerialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Placeholder(),
    );
  }
}
