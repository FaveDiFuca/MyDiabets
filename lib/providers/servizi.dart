import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';

Future<Map<String, dynamic>> ottieniDatiAlimentoDaUrl(String urlString) async {
  try {
    final url = Uri.parse(urlString);
    final Response risposta = await http.get(url).timeout(Duration(seconds: 10)); //aggiunto timeout

    if (risposta.statusCode == 200) {
      final dati = json.decode(risposta.body);
      if (dati['status'] == 1) {
        return dati['product'];
      } else {
        throw Exception('Prodotto non trovato');
      }
    } else {
      print('Errore nella richiesta: ${risposta.statusCode}'); //aggiunto print
      throw Exception('Errore nella richiesta: ${risposta.statusCode}');
    }
  } on TimeoutException catch (_) {
    throw Exception('Timeout di connessione');
  } catch (e) {
    throw Exception('Errore di connessione: $e');
  }
}