import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

class SerialReceiverScreen extends StatefulWidget {
  const SerialReceiverScreen({super.key});

  @override
  State<SerialReceiverScreen> createState() => _SerialRXState();
}

class _SerialRXState extends State<SerialReceiverScreen> {
  late SerialPortReader reader;
  SerialPort port = SerialPort("/dev/ttyS4");
  late final AppLifecycleListener _listener;
  List<String> received = [];

  @override
  void initState() {
    super.initState();
    reader = SerialPortReader(port);
    _listener = AppLifecycleListener(
      onInactive: () {
        port.close();
        reader.close();
      },
      onResume: () {
        port.openReadWrite();
        startListen();
      },
    );
    _initPort();
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
      startListen();
    } catch (error) {
      print(error);
    }
  }

  void startListen() {
    reader.stream.listen((data) {
      setState(() {
        received.add(String.fromCharCodes(data));
      });
    }, onError: (error) => print(error));
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
            subtitle: Text(
              index.toString(),
              style: const TextStyle(fontSize: 25),
            ),
          );
        },
      ),
    );
  }

  @override
  void deactivate() {
    reader.close();
    port.close();
    port.dispose();
    _listener.dispose();
    super.deactivate();
  }
}
