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
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _initPort();
    _listener = AppLifecycleListener(
      onInactive: () => port.close(),
      onResume: () => port.openReadWrite(),
    );
  }

  void _initPort() {
    try {
      port.openReadWrite();
      port.config = SerialPortConfig()
        ..baudRate = 115200
        ..bits = 8
        ..stopBits = 1
        ..parity = SerialPortParity.none
        ..setFlowControl(SerialPortFlowControl.none);
    } catch (error) {
      print(error);
    }
  }

  void _sayHelloWorld() {
    if (!port.isOpen) return;
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
              child: const Text(
                "Say Hello World",
                style: TextStyle(fontSize: 100),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    port.dispose();
    _listener.dispose();
    super.dispose();
  }
}
