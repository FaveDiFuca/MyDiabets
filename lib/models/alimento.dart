import 'dart:convert';

class Alimento {
  final String nome;
  final double? indiceGlicemico;
  final double? caricoGlicemico;
  final double? proteine;
  final double? carboidrati;
  final double? fibra;
  final double? zuccheri;
  final double? zuccheriAggiunti;
  final double? grassi;
  final double? saturi;
  final double? monoinsaturi;
  final double? polinsaturi;
  final double? trans;
  final double? calorie; // Aggiunto campo calorie
  final Map<String, num?>? altro;
  final Map<String, num?>? vitamine;
  final Map<String, num?>? minerali;

  Alimento({
    required this.nome,
    this.indiceGlicemico,
    this.caricoGlicemico,
    this.proteine,
    this.carboidrati,
    this.fibra,
    this.zuccheri,
    this.zuccheriAggiunti,
    this.grassi,
    this.saturi,
    this.monoinsaturi,
    this.polinsaturi,
    this.trans,
    this.calorie, // Inizializza calorie
    this.altro,
    this.vitamine,
    this.minerali,
  });

  factory Alimento.fromJson(Map<String, dynamic> json) {
    return Alimento(
      nome: json['nome'] ?? 'Nome non disponibile',
      indiceGlicemico: json['indice_glicemico']?.toDouble(),
      caricoGlicemico: json['carico_glicemico']?.toDouble(),
      proteine: json['proteine']?.toDouble(),
      carboidrati: json['carboidrati']?.toDouble(),
      fibra: json['fibra']?.toDouble(),
      zuccheri: json['zuccheri']?.toDouble(),
      zuccheriAggiunti: json['zuccheri_aggiunti']?.toDouble(),
      grassi: json['grassi']?.toDouble(),
      saturi: json['saturi']?.toDouble(),
      monoinsaturi: json['monoinsaturi']?.toDouble(),
      polinsaturi: json['polinsaturi']?.toDouble(),
      trans: json['trans']?.toDouble(),
      calorie: json['calorie']?.toDouble(), // Aggiunto parsing calorie
      altro: Map<String, num?>.from(json['altro'] ?? {}),
      vitamine: Map<String, num?>.from(json['vitamine'] ?? {}),
      minerali: Map<String, num?>.from(json['minerali'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'indiceGlicemico': indiceGlicemico,
      'caricoGlicemico': caricoGlicemico,
      'proteine': proteine,
      'carboidrati': carboidrati,
      'fibra': fibra,
      'zuccheri': zuccheri,
      'zuccheriAggiunti': zuccheriAggiunti,
      'grassi': grassi,
      'saturi': saturi,
      'monoinsaturi': monoinsaturi,
      'polinsaturi': polinsaturi,
      'trans': trans,
      'calorie': calorie, // Aggiunto al JSON
      'vitamine': vitamine,
      'minerali': minerali,
    };
  }
}