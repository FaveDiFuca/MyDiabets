import 'package:flutter/material.dart';

class TotalInfoWidget extends StatelessWidget {
  final double calorie;
  final double indiceGlicemico;
  final double proteine;
  final double carboidrati;
  final double zuccheri;
  final double grassi;

  const TotalInfoWidget({
    Key? key,
    required this.calorie,
    required this.indiceGlicemico,
    required this.proteine,
    required this.carboidrati,
    required this.zuccheri,
    required this.grassi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Log per verificare i dati che arrivano nel widget
    print('Dati ricevuti nel widget: Calorie: $calorie, IG: $indiceGlicemico, Proteine: $proteine, Carboidrati: $carboidrati, Zuccheri: $zuccheri, Grassi: $grassi');

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white, // Contenuto principale della pagina
              child: Center(child: Text('Contenuto della pagina')),
            ),
          ),
          // Posizionamento del TotalInfoWidget in basso
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity, // Occupa tutta la larghezza
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDataBox("Cal", calorie),
                  _buildDataBox("IG", indiceGlicemico),
                  _buildDataBox("Pro", proteine),
                  _buildDataBox("Carb", carboidrati),
                  _buildDataBox("Zuc", zuccheri),
                  _buildDataBox("Gras", grassi),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataBox(String label, double value) {
    // Log per ogni chiamata al widget per il dato
    print('Costruito DataBox per: $label con valore: $value');
    
    return Column(
      mainAxisSize: MainAxisSize.min, // Rende il widget adattabile al contenuto
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          value.toStringAsFixed(1),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}