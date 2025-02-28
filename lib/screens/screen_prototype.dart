import 'package:flutter/material.dart';
import '../widgets/service_bar.dart';
import '../navigation/custom_navigation_bar.dart'; // Aggiorna l'importazione
import 'dart:developer' as developer;

class ScreenPrototype extends StatefulWidget {
  final Widget child;
  final String title;
  final int initialIndex;

  ScreenPrototype({
    required this.child,
    required this.title,
    this.initialIndex = 0,
  });

  @override
  _ScreenPrototypeState createState() => _ScreenPrototypeState();
}

class _ScreenPrototypeState extends State<ScreenPrototype> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: ServiceBar(),
      ),
      body: SingleChildScrollView(
        child: widget.child,
      ),
 	 bottomNavigationBar: CustomNavigationBar( // Usa CustomNavigationBar
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}