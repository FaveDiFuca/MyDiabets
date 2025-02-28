import 'dart:convert';
import 'dart:io';
import 'package:my_diabetes_app/models/utente.dart';
import 'package:path_provider/path_provider.dart';

// Carica l'utente da JSON
class DataStorage {
  static Future<Utente?> loadUser() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/utente.json');
      if (await file.exists()) {
        String contents = await file.readAsString();
        Map<String, dynamic> json = jsonDecode(contents);
        return Utente.fromJson(json);  // Assicurati di avere un metodo `fromJson` nel tuo modello `Utente`
      }
    } catch (e) {
      print("Errore durante il caricamento dell'utente: $e");
    }
    return null;
  }

  // Salva l'utente su JSON
  static Future<void> saveUser(Utente utente) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/utente.json');
      String json = jsonEncode(utente.toJson());  // Assicurati di avere un metodo `toJson` nel tuo modello `Utente`
      await file.writeAsString(json);
    } catch (e) {
      print("Errore durante il salvataggio dell'utente: $e");
    }
  }

  // Altri metodi per gestire il database o altri archivi
  static Future<Utente?> loadUserFromDatabase() async {
    // Implementa la logica di caricamento da database (ad esempio SQLite)
    return null;
  }

  static Future<void> saveUserToDatabase(Utente utente) async {
    // Implementa la logica di salvataggio nel database
  }
}
