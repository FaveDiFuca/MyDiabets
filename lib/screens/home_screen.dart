import 'package:flutter/material.dart';
import '../widgets/service_bar.dart';
import 'contents/home_content.dart';
import 'dart:developer' as developer;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    developer.log('HomeScreen: build');

    return Scaffold(
      appBar: AppBar(
        title: Text('My Diabetes App'),
        bottom: ServiceBar(),
      ),
      body: SingleChildScrollView(
        child: HomeContent(),
      ),
    );
  }
}