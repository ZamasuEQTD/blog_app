abstract class Usuario {
  final String username;
  final String token;
  const Usuario({required this.username, required this.token});
}

class Anonimo extends Usuario {
  const Anonimo({required super.username, required super.token});
}

class Moderador extends Usuario {
  final String moderador;
  const Moderador(
      {required this.moderador, required super.username, required super.token});
}
