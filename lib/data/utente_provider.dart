import 'package:flutter/material.dart';
import 'package:my_diabetes_app/services/data_storage.dart';
import '../models/utente.dart';
import 'package:sqflite/sqflite.dart';

class UtenteProvider with ChangeNotifier {
  final DataStorageInterface dataStorage;
  Utente? _utente;

  UtenteProvider({required this.dataStorage}) {
    print("UtenteProvider: Inizializzato");
  }

  Utente? get utente => _utente;

  Future<void> caricaUtente() async {
    print("UtenteProvider: caricaUtente() chiamata");
    _utente = await dataStorage.caricaDatiUtente();
    print("UtenteProvider: Utente caricato: ${_utente?.toMap()}");
    notifyListeners();
  }

Future<void> registraUtente({
    required String email,
    required String password,
    required String nome,
    required String cognome,
    required BuildContext context,
  }) async {
    // ... (codice precedente)
  }
}