// lib/providers/pasto_provider.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/alimento.dart';
import '../config.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../services/nutritional_loader.dart';

class PastoProvider with ChangeNotifier {
  Database? _database;
  List<Alimento> _alimenti = [];
  List<String> _pasti = ['COLAZIONE', 'SPUNTINO', 'PRANZO', 'MERENDA', 'CENA'];
  Map<String, List<Alimento>> _pastiConAlimenti = {};

  Database? get database => _database;
  set database(Database? database) {
    _database = database;
    notifyListeners();
  }

  List<Alimento> get alimenti => _alimenti;
  set alimenti(List<Alimento> alimenti) {
    _alimenti = alimenti;
    notifyListeners();
  }

  List<String> get pasti => _pasti;

  Map<String, List<Alimento>> get pastiConAlimenti => _pastiConAlimenti;

  // Funzione per caricare gli alimenti
  Future<void> caricaAlimenti() async {
    final loader = NutritionalLoader();
    _alimenti = await loader.loadNutritionalData(Config.alimentiJsonPath);
    notifyListeners();
  }

  Future<void> aggiungiAlimentoAlPasto(String pasto, Alimento alimento, String quantita) {
    print('Aggiungendo alimento: ${alimento.nome} al pasto: $pasto con quantità: $quantita');
    if (_pastiConAlimenti.containsKey(pasto)) {
      _pastiConAlimenti[pasto]!.add(alimento);
    } else {
      _pastiConAlimenti[pasto] = [alimento];
    }
    notifyListeners();
    print('Alimenti per $pasto: ${_pastiConAlimenti[pasto]}');
    return Future.value();
  }

  Alimento? ottieniAlimentoPerNome(String nome) {
    for (var alimento in _alimenti) {
      if (alimento.nome.toLowerCase() == nome.toLowerCase()) {
        return alimento;
      }
    }
    return null;
  }
}