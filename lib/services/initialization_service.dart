import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pasto_provider.dart';
import '../providers/utente_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../config.dart';
import '../models/alimento.dart';
import 'package:path_provider/path_provider.dart';
import '../models/utente.dart';
import 'dart:developer' as developer; // Aggiungi import

class InitializationService {
  static Future<void> initialize(BuildContext context) async {
    developer.log('initialization_service.dart: Inizio inizializzazione'); // Aggiunto log
    await _initDatabase(context);
    await _loadJson(context);
    await _loadUtente(context);
    developer.log('initialization_service.dart: Inizializzazione completata'); // Aggiunto log
  }

static Future<void> _initDatabase(BuildContext context) async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final path = join(documentsDirectory.path, 'utente.db');
  final database = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE utente(email TEXT PRIMARY KEY, nome TEXT, cognome TEXT, dataNascita TEXT, sesso TEXT, peso TEXT, altezza TEXT, girovita TEXT, glicemia TEXT, emoglobinaGlicata TEXT)',
      );
    },
  );
  
  // Imposta il database nel provider
  Provider.of<UtenteProvider>(context, listen: false).database = database;
  developer.log('initialization_service.dart: Database inizializzato');
}

  static Future<void> _loadJson(BuildContext context) async {
    try {
      String jsonString = await rootBundle.loadString(Config.alimentiJsonPath);
      List<dynamic> alimenti = json.decode(jsonString);
      Provider.of<PastoProvider>(context, listen: false).alimenti =
          alimenti.map((alimento) => Alimento.fromJson(alimento)).toList();
      developer.log('initialization_service.dart: JSON caricato');
    } catch (e) {
      print('Errore durante il caricamento del JSON: $e');
      developer.log('initialization_service.dart: Errore caricamento JSON: $e');
    }
  }

static Future<void> _loadUtente(BuildContext context) async {
  try {
    // Carica l'utente
    await Provider.of<UtenteProvider>(context, listen: false).caricaUtente();
    developer.log('initialization_service.dart: Utente caricato');
  } catch (e) {
    print('Errore durante il caricamento dell\'utente: $e');
    developer.log('initialization_service.dart: Errore caricamento utente: $e');
  }
}
}