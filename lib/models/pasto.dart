class Pasto {
  final String nome;
  final DateTime data;
  final List<Cibo> cibi;

  Pasto({
    required this.nome,
    required this.data,
    required this.cibi,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'data': data.toIso8601String(),
      'cibi': cibi.map((cibo) => cibo.toMap()).toList(),
    };
  }

  factory Pasto.fromMap(Map<String, dynamic> map) {
    return Pasto(
      nome: map['nome'],
      data: DateTime.parse(map['data']),
      cibi: (map['cibi'] as List).map((ciboMap) => Cibo.fromMap(ciboMap)).toList(),
    );
  }
}

class Cibo {
  final int? id;
  String _nome; // Usa il campo privato _nome
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
  final double? poliinsaturi;
  final double? trans;
  final double? colesterolo;
  final double? sodio;
  final double? sale;
  final double? acqua;
  final double? alcool;
  final Map<Vitamine, double?> vitamine;
  final Map<Minerali, double?> minerali;

  Cibo({
    this.id,
    required String nome, // Rimuovi final, cambia a String nome
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
    this.poliinsaturi,
    this.trans,
    this.colesterolo,
    this.sodio,
    this.sale,
    this.acqua,
    this.alcool,
    required this.vitamine,
    required this.minerali,
  }) : _nome = nome; // Inizializza _nome nel costruttore

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': _nome, // Usa _nome nella mappa
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
      'poliinsaturi': poliinsaturi,
      'trans': trans,
      'colesterolo': colesterolo,
      'sodio': sodio,
      'sale': sale,
      'acqua': acqua,
      'alcool': alcool,
      'vitamine': vitamine.map((key, value) => MapEntry(key.toString(), value)),
      'minerali': minerali.map((key, value) => MapEntry(key.toString(), value)),
    };
  }

  factory Cibo.fromMap(Map<String, dynamic> map) {
    return Cibo(
      id: map['id'],
      nome: map['nome'], // Usa nome dalla mappa
      indiceGlicemico: map['indiceGlicemico'],
      caricoGlicemico: map['caricoGlicemico'],
      proteine: map['proteine'],
      carboidrati: map['carboidrati'],
      fibra: map['fibra'],
      zuccheri: map['zuccheri'],
      zuccheriAggiunti: map['zuccheriAggiunti'],
      grassi: map['grassi'],
      saturi: map['saturi'],
      monoinsaturi: map['monoinsaturi'],
      poliinsaturi: map['poliinsaturi'],
      trans: map['trans'],
      colesterolo: map['colesterolo'],
      sodio: map['sodio'],
      sale: map['sale'],
      acqua: map['acqua'],
      alcool: map['alcool'],
      vitamine: (map['vitamine'] as Map).map((key, value) => MapEntry(Vitamine.values.firstWhere((e) => e.toString() == key), value)),
      minerali: (map['minerali'] as Map).map((key, value) => MapEntry(Minerali.values.firstWhere((e) => e.toString() == key), value)),
    );
  }

  String get nome => _nome;
  set nome(String nome) => _nome = nome;
}

enum Vitamine {
  A,
  B1,
  B11,
  B12,
  B2,
  B3,
  B5,
  B6,
  B7,
  C,
  D,
  E,
  K,
}

enum Minerali {
  calcio,
  ferro,
  fosforo,
  magnesio,
  manganese,
  potassio,
  rame,
  selenio,
  zinco,
}