abstract class Usuario {
  final String id;
  final String username;

  Usuario({required this.id, required this.username});
}

class Anonimo extends Usuario {
  Anonimo({required super.id, required super.username});
}

class Moderador extends Usuario {
  final String moderador;

  Moderador({required super.id, required super.username, required this.moderador}); 
}