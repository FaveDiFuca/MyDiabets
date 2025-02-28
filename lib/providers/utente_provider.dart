import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/utente.dart';
import '../services/data_storage.dart'; // Assicurati che questo import sia corretto

class UtenteProvider with ChangeNotifier {
  Utente? _utente;
  late Database _database;

  // Getter per l'utente
  Utente? get utente => _utente;

  // Getter e Setter per il database
  Database get database => _database;

  set database(Database db) {
    _database = db;
    notifyListeners();  // Notifica che c'è stato un cambiamento
  }

  // Metodo per caricare l'utente dal database
  Future<void> caricaUtente() async {
    try {
      // Usa il tuo metodo DataStorage per caricare l'utente
      _utente = await DataStorage.loadUserFromDatabase();
      notifyListeners();
    } catch (e) {
      throw Exception('Errore durante il caricamento dell\'utente: $e');
    }
  }

  // Metodo per salvare l'utente nel database
  Future<void> salvaUtente(Utente utente) async {
    try {
      await DataStorage.saveUserToDatabase(utente);
      _utente = utente;
      notifyListeners();
    } catch (e) {
      throw Exception('Errore durante il salvataggio dell\'utente: $e');
    }
  }
}
