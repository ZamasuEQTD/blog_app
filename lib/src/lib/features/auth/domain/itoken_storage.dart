abstract class ItokenStorage {
  Future<void> guardar(String token);
  Future<String?> recuperar();
}
