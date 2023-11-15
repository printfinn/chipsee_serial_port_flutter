import 'package:flutter/material.dart';
import 'package:serial_app/serial_rx_screen.dart';
import 'package:serial_app/serial_tx_screen.dart';

void main() {
  runApp(const MySerialApp());
}

class MySerialApp extends StatelessWidget {
  const MySerialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavi(),
    );
  }
}

class BottomNavi extends StatefulWidget {
  const BottomNavi({super.key});

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.call_made),
            label: 'TX',
          ),
          NavigationDestination(
            icon: Icon(Icons.call_received),
            label: 'RX',
          ),
        ],
      ),
      body: <Widget>[
        const SerialTXScreen(),
        const SerialRXScreen(),
      ][currentPageIndex],
    );
  }
}

