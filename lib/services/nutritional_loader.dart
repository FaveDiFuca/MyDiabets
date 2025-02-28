// lib/services/nutritional_loader.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/alimento.dart';

class NutritionalLoader {
  // Funzione per caricare i dati nutrizionali dal file JSON
  Future<List<Alimento>> loadNutritionalData(String jsonPath) async {
    try {
      // Carica il file JSON
      String jsonString = await rootBundle.loadString(jsonPath);
      List<dynamic> jsonData = json.decode(jsonString);

      // Mappa i dati in oggetti Alimento
      List<Alimento> alimenti = jsonData.map((item) => Alimento.fromJson(item)).toList();
      return alimenti;
    } catch (e) {
      print("Errore nel caricamento dei dati nutrizionali: $e");
      return [];
    }
  }
}