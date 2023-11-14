import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

class SerialScreen extends StatefulWidget {
  const SerialScreen({super.key});

  @override
  State<SerialScreen> createState() => _SerialScreenState();
}

class _SerialScreenState extends State<SerialScreen> {
  SerialPort port = SerialPort("/dev/ttyS4");
  late Timer timer;
  String name = "Hello World";

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(milliseconds: 500), () => _initPort());
  }

  void _initPort() {
    port.openReadWrite();
    port.config = SerialPortConfig()
      ..baudRate = 115200
      ..bits = 8
      ..stopBits = 1
      ..parity = SerialPortParity.none
      ..setFlowControl(SerialPortFlowControl.none);
  }

  void _sayHelloWorld() {
    port.write(Uint8List.fromList("Hello World\n".codeUnits));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chipsee Serial App Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _sayHelloWorld,
              child: Text(
                name,
                style: TextStyle(fontSize: 100),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    port.close();
    port.dispose();
    timer.cancel();
    super.deactivate();
  }
}
