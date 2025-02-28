class Utente {
  final String email;
  final String nome;
  final String cognome;
  final String dataNascita;
  final String sesso;
  final String peso;
  final String altezza;
  final String girovita;
  final String glicemia;
  final String emoglobinaGlicata;

  Utente({
    required this.email,
    required this.nome,
    required this.cognome,
    required this.dataNascita,
    required this.sesso,
    required this.peso,
    required this.altezza,
    required this.girovita,
    required this.glicemia,
    required this.emoglobinaGlicata,
  });

  // Metodo per creare un Utente da JSON
  factory Utente.fromJson(Map<String, dynamic> json) {
    return Utente(
      email: json['email'],
      nome: json['nome'],
      cognome: json['cognome'],
      dataNascita: json['dataNascita'],
      sesso: json['sesso'],
      peso: json['peso'],
      altezza: json['altezza'],
      girovita: json['girovita'],
      glicemia: json['glicemia'],
      emoglobinaGlicata: json['emoglobinaGlicata'],
    );
  }

  // Metodo per convertire l'Utente in JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'nome': nome,
      'cognome': cognome,
      'dataNascita': dataNascita,
      'sesso': sesso,
      'peso': peso,
      'altezza': altezza,
      'girovita': girovita,
      'glicemia': glicemia,
      'emoglobinaGlicata': emoglobinaGlicata,
    };
  }
}
