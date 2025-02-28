import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/pasti_screen.dart';
import 'providers/utente_provider.dart';
import 'providers/pasto_provider.dart';
import 'navigation/custom_navigation_bar.dart';
import 'dart:developer' as developer;
import 'services/initialization_service.dart';

void main() {
  developer.log('main.dart: Avvio dell\'applicazione');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  bool _initialized = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    developer.log('MyApp: build, selectedIndex: $_selectedIndex, initialized: $_initialized');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UtenteProvider>(create: (_) => UtenteProvider()),
        ChangeNotifierProvider<PastoProvider>(create: (_) => PastoProvider()),
      ],
      child: Builder(
        builder: (context) {
          if (!_initialized) {
            // A questo punto siamo sicuri che il contesto ha accesso ai Provider
            _initializeApp(context);
            return MaterialApp(
              title: 'My Diabetes App',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else {
            return MaterialApp(
              title: 'My Diabetes App',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: Scaffold(
                body: Stack(
                  children: <Widget>[
                    Offstage(
                      offstage: _selectedIndex != 0,
                      child: HomeScreen(),
                    ),
                    Offstage(
                      offstage: _selectedIndex != 1,
                      child: ProfileScreen(),
                    ),
                    Offstage(
                      offstage: _selectedIndex != 2,
                      child: PastiScreen(),
                    ),
                  ],
                ),
                bottomNavigationBar: CustomNavigationBar(
                  selectedIndex: _selectedIndex,
                  onItemTapped: _onItemTapped,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _initializeApp(BuildContext context) async {
    await InitializationService.initialize(context);
    setState(() {
      _initialized = true;
    });
  }
}