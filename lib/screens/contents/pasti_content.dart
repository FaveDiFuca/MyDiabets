import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/pasto_provider.dart';
import '../../models/alimento.dart';

class PastiContent extends StatefulWidget {
  @override
  _PastiContentState createState() => _PastiContentState();
}

class _PastiContentState extends State<PastiContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _ricercaController = TextEditingController();
  final TextEditingController _quantitaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this); // 5 tabs per i pasti
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pasti Giornalieri'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Colazione'),
            Tab(text: 'Spuntino'),
            Tab(text: 'Pranzo'),
            Tab(text: 'Merenda'),
            Tab(text: 'Cena'),
          ],
        ),
      ),
      body: SingleChildScrollView( // Aggiunto per abilitare lo scroll
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ricercaController,
                    decoration: InputDecoration(labelText: 'Nome alimento'),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _quantitaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Quantità (g)'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final alimento = Provider.of<PastoProvider>(context, listen: false)
                        .ottieniAlimentoPerNome(_ricercaController.text);
                    if (alimento != null) {
                      String selectedPasto = _tabController.index == 0
                          ? 'Colazione'
                          : _tabController.index == 1
                              ? 'Spuntino 1'
                              : _tabController.index == 2
                                  ? 'Pranzo'
                                  : _tabController.index == 3
                                      ? 'Merenda'
                                      : 'Cena';

                      Provider.of<PastoProvider>(context, listen: false)
                          .aggiungiAlimentoAlPasto(selectedPasto, alimento, _quantitaController.text);

                      // Svuota i campi dopo l'aggiunta
                      _ricercaController.clear();
                      _quantitaController.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Alimento non trovato')),
                      );
                    }
                  },
                  child: Text('Aggiungi'),
                ),
              ],
            ),

            // Solo i tab con alimenti reali
            Container(
              height: 400, // Altezza fissa per il TabBarView
              child: TabBarView(
                controller: _tabController,
                children: [
                  _pastiContentView('Colazione'),
                  _pastiContentView('Spuntino 1'),
                  _pastiContentView('Pranzo'),
                  _pastiContentView('Merenda'),
                  _pastiContentView('Cena'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Funzione per visualizzare il contenuto del pasto con gli alimenti
  Widget _pastiContentView(String pasto) {
    return Consumer<PastoProvider>(
      builder: (context, pastoProvider, child) {
        final alimentiPasto = pastoProvider.pastiConAlimenti[pasto] ?? [];
        return ListView.builder(
          itemCount: alimentiPasto.length,
          itemBuilder: (context, index) {
            final alimento = alimentiPasto[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildDataBox("Nome", alimento.nome),
                    _buildDataBox("Cal", alimento.calorie),
                    _buildDataBox("IG", alimento.indiceGlicemico),
                    _buildDataBox("Pro", alimento.proteine),
                    _buildDataBox("Carb", alimento.carboidrati),
                    _buildDataBox("Zuc", alimento.zuccheri),
                    _buildDataBox("Gras", alimento.grassi),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Funzione per costruire una colonna di dati (etichetta + valore)
  Widget _buildDataBox(String label, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        Text(
          value != null ? value.toString() : "-",
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}