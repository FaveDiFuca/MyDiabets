import '../models/utente.dart';
import '../models/pasto.dart';

abstract class DataStorageInterface {
  Future<void> salvaDatiUtente(Utente utente);
  Future<Utente?> caricaDatiUtente();
  Future<void> eliminaDatiUtente();

  Future<void> salvaPasto(Pasto pasto);
  Future<List<Pasto>> caricaPasti(DateTime data);
  Future<void> eliminaPasto(Pasto pasto);
  // ... altri metodi per alimenti, storico, ecc.
}