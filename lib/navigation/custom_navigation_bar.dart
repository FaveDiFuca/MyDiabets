import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class CustomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomNavigationBar({required this.selectedIndex, required this.onItemTapped});

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    developer.log('CustomNavigationBar: build, selectedIndex: ${widget.selectedIndex}');

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profilo',
        ),
        BottomNavigationBarItem( // Aggiungi Pasti
          icon: Icon(Icons.restaurant_menu),
          label: 'Pasti',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (int index) {
        developer.log('CustomNavigationBar: onTap, index: $index');
        widget.onItemTapped(index);
      },
    );
  }
}