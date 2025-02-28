// lib/services/pasto_manager.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/alimento.dart';
import '../providers/pasto_provider.dart';

class PastoManager {
  final BuildContext context;
  String pastoCorrente = 'Colazione';
  List<Map<String, dynamic>> alimentiPastoCorrente = [];
  double calorieTotali = 0;
  double indiceGlicemicoTotale = 0;
  double caricoGlicemicoTotale = 0;
  double carboidratiTotali = 0;
  double grassiTotali = 0;
  double proteineTotali = 0;

  PastoManager(this.context);

  void selezionaPasto(String pasto) {
    pastoCorrente = pasto;
    alimentiPastoCorrente.clear();
    calcolaTotali();
  }

void aggiungiAlimento(Alimento alimento, String quantitaString) {
  double? quantita = double.tryParse(quantitaString);
  if (quantita != null) {
    // Aggiungi l'alimento al pasto tramite il provider
    final pastoProvider = Provider.of<PastoProvider>(context, listen: false);
    pastoProvider.aggiungiAlimentoAlPasto(pastoCorrente, alimento, quantitaString);
    calcolaTotali();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Inserisci una quantità valida.')),
    );
  }
}

  void calcolaTotali() {
    calorieTotali = 0;
    indiceGlicemicoTotale = 0;
    caricoGlicemicoTotale = 0;
    carboidratiTotali = 0;
    grassiTotali = 0;
    proteineTotali = 0;

    for (var alimentoMap in alimentiPastoCorrente) {
      final alimento = alimentoMap['alimento'] as Alimento;
      final quantita = alimentoMap['quantita'] as double;

      calorieTotali += (alimento.carboidrati ?? 0) * 4 * quantita;
      indiceGlicemicoTotale += (alimento.indiceGlicemico ?? 0) * quantita;
      caricoGlicemicoTotale += (alimento.caricoGlicemico ?? 0) * quantita;
      carboidratiTotali += (alimento.carboidrati ?? 0) * quantita;
      grassiTotali += (alimento.grassi ?? 0) * quantita;
      proteineTotali += (alimento.proteine ?? 0) * quantita;
    }
  }

  // Funzione per ottenere gli alimenti in base al nome
  Alimento? ottieniAlimentoPerNome(String nome) {
    return Provider.of<PastoProvider>(context, listen: false)
        .ottieniAlimentoPerNome(nome);
  }
}