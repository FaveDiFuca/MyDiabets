import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_diabetes_app/models/utente.dart';
import 'package:my_diabetes_app/providers/utente_provider.dart';
import 'package:my_diabetes_app/screens/contents/profile_content.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UtenteProvider>(context, listen: false).loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profilo'),
      ),
      body: Consumer<UtenteProvider>(
        builder: (context, utenteProvider, child) {
          if (utenteProvider.utente == null) {
            return Center(child: CircularProgressIndicator());
          }

          Utente utente = utenteProvider.utente!;

          return SingleChildScrollView(
            child: ProfileContent(utente: utente),
          );
        },
      ),
    );
  }
}
