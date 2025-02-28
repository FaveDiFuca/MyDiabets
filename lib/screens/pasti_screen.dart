import 'package:flutter/material.dart';
import 'contents/pasti_content.dart';

class PastiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuovo pasto'),
      ),
      body: PastiContent(), // Usa PastiContent come contenuto
    );
  }
}