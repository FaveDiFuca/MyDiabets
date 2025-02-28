import 'package:flutter/material.dart';
import 'package:my_diabetes_app/models/utente.dart';

class ProfileContent extends StatelessWidget {
  final Utente utente;

  ProfileContent({required this.utente});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nome: ${utente.nome} ${utente.cognome}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Email: ${utente.email}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Data di Nascita: ${utente.dataNascita}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Sesso: ${utente.sesso}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Peso: ${utente.peso} kg', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Altezza: ${utente.altezza} cm', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Girovita: ${utente.girovita} cm', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Glicemia: ${utente.glicemia} mg/dl', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Emoglobina Glicata: ${utente.emoglobinaGlicata}%', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
