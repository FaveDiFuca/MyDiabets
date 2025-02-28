import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/utente.dart';
import 'data_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage implements DataStorageInterface {
  Database? _db;
  final _storage = FlutterSecureStorage();

  Future<Database> get db async {
    if (_db != null) return _db!;

    print("local_storage.dart: Inizio inizializzazione del database");
    _db = await _initDB();
    print("local_storage.dart: Inizializzazione del database completata");
    return _db!;
  }

  Future<Database> _initDB() async {
    print("LocalStorage: _initDB() chiamata");
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'mydiabetes.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        print("LocalStorage: _initDB() onCreate chiamata");
        await db.execute('''
          CREATE TABLE utente (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT,
            nome TEXT,
            cognome TEXT,
            nomeVisualizzato TEXT,
            dataNascita TEXT,
            sesso TEXT,
            peso REAL,
            altezza REAL,
            girovita REAL,
            glicemia REAL,
            emoglobinaGlicata REAL
          )
        ''');
      },
    );
  }

  @override
  Future<Utente?> caricaDatiUtente() async {
    print("local_storage.dart: caricaDatiUtente() chiamata");
    final dbClient = await db;
    try {
      print("local_storage.dart: Esecuzione query per caricare l'utente");
      final String sql = 'SELECT * FROM utente';
      print("local_storage.dart: Query SQL: $sql");
      final List<Map<String, dynamic>> maps = await dbClient.rawQuery(sql);
      print("caricaDatiUtente: Risultato grezzo: $maps");
      print("caricaDatiUtente: Numero di risultati: ${maps.length}");

      if (maps.isNotEmpty) {
        print("caricaDatiUtente: Primo risultato: ${maps.first}");
        try {
          final utente = Utente.fromMap(maps.first);
          print("caricaDatiUtente: Utente creato: ${utente.toMap()}");
          return utente;
        } catch (e) {
          print("caricaDatiUtente: Errore durante Utente.fromMap: $e");
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Errore durante il caricamento dell\'utente: $e');
      return null;
    }
  }

  @override
  Future<void> salvaDatiUtente(Utente utente) async {
    final dbClient = await db;
    try {
      print("LocalStorage: salvaDatiUtente() chiamata");
      print("LocalStorage: salvaDatiUtente() - Dati utente: ${utente.toMap()}");
      await dbClient.insert('utente', utente.toMap());
      print("LocalStorage: salvaDatiUtente() - Utente salvato");
    } catch (e) {
      print("LocalStorage: salvaDatiUtente() - Errore: $e");
      rethrow;
    }
  }

@override
  Future<bool> getPrimoAvvio() async {
    final primoAvvio = await _storage.read(key: 'primoAvvio') ?? 'true';
    print("LocalStorage: getPrimoAvvio() - primoAvvio: $primoAvvio");
    return primoAvvio == 'true';
  }

  @override
  Future<void> setPrimoAvvio(bool value) async {
    await _storage.write(key: 'primoAvvio', value: value.toString());
    print("LocalStorage: setPrimoAvvio() - primoAvvio: $value");
    print("LocalStorage: setPrimoAvvio() - SecureStorage: ${await _storage.read(key: 'primoAvvio')}");
  }
}