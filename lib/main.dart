import 'package:flutter/material.dart';
import 'package:serial_app/serial_receiver_screen.dart';
import 'package:serial_app/serial_screen.dart';

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
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Send',
          ),
          NavigationDestination(
            icon: Icon(Icons.business),
            label: 'Receive',
          ),
        ],
      ),
      body: <Widget>[
        const SerialScreen(),
        const SerialReceiverScreen(),
      ][currentPageIndex],
    );
  }
}
