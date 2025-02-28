import 'package:flutter/material.dart';
import 'package:my_diabetes_app/providers/utente_provider.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nomeController = TextEditingController();
  final _cognomeController = TextEditingController();
  String? _errorMessage; // Aggiungi una variabile per il messaggio di errore

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      final utenteProvider = Provider.of<UtenteProvider>(context, listen: false);
      try {
        await utenteProvider.registraUtente(
          email: _emailController.text,
          password: _passwordController.text,
          nome: _nomeController.text,
          cognome: _cognomeController.text,
        );
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        setState(() {
          _errorMessage = e.toString(); // Imposta il messaggio di errore
        });
        print('Errore durante la registrazione: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrazione')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
              TextFormField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
              TextFormField(controller: _nomeController, decoration: InputDecoration(labelText: 'Nome')),
              TextFormField(controller: _cognomeController, decoration: InputDecoration(labelText: 'Cognome')),
              if (_errorMessage != null) // Mostra il messaggio di errore se presente
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
ElevatedButton(
onPressed: () async {
  if (_formKey.currentState!.validate()) {
    try {
      print("registration_screen: Contesto: $context"); // Log aggiuntivo
      await Provider.of<UtenteProvider>(context, listen: false).registraUtente(
        email: _emailController.text,
        password: _passwordController.text,
        nome: _nomeController.text,
        cognome: _cognomeController.text,
        context: context,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore durante la registrazione: $e')),
      );
    }
  }
},
  child: Text('Registrati'),
)
            ],
          ),
        ),
      ),
    );
  }
}