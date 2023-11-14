import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

class SerialReceiverScreen extends StatefulWidget {
  const SerialReceiverScreen({super.key});

  @override
  State<SerialReceiverScreen> createState() => _SerialRXState();
}

class _SerialRXState extends State<SerialReceiverScreen> {
  SerialPort port = SerialPort("/dev/ttyS4");
  late SerialPortReader reader;
  List<String> received = [];
  late Timer timer;

  @override
  void initState() {
    super.initState();
    reader = SerialPortReader(port);
    timer = Timer(
      const Duration(milliseconds: 500),
      () {
        _initPort();
        startListen();
      },
    );
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

  void startListen() {
    reader.stream.listen((data) {
      setState(() {
        received.add(String.fromCharCodes(data));
      });
    }, onError: (error) => print(error));
  }

  void clearList() {
    setState(() {
      received = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chipsee Serial App Demo"),
      ),
      body: ListView.builder(
        itemCount: received.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              received[index],
              style: const TextStyle(fontSize: 30),
            ),
            leading: Text(
              index.toString(),
              style: const TextStyle(fontSize: 30),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: clearList,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  @override
  void deactivate() {
    timer.cancel();
    reader.close();
    port.close();
    port.dispose();
    super.deactivate();
  }
}
