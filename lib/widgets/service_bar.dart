import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/utente_provider.dart';

class ServiceBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60.0);

  double _calcolaBMI(double peso, double altezza) {
    if (altezza == 0) return 0;
    double altezzaMetri = altezza / 100;
    return peso / (altezzaMetri * altezzaMetri);
  }

  @override
  Widget build(BuildContext context) {
    final utente = Provider.of<UtenteProvider>(context).utente;
    double peso = double.tryParse(utente?.peso ?? '0') ?? 0;
    double altezza = double.tryParse(utente?.altezza ?? '0') ?? 0;
    double bmi = _calcolaBMI(peso, altezza);

    return PreferredSize(
      preferredSize: preferredSize,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('Peso: ${utente?.peso ?? '-'} kg'),
            Text('BMI: ${bmi.toStringAsFixed(1)}'),
            Text('Glicemia: ${utente?.glicemia ?? '-'} mg/dL'),
            Text('HbA1c: ${utente?.emoglobinaGlicata ?? '-'} %'),
          ],
        ),
      ),
    );
  }
}