abstract class ComentarioEntry {
  const ComentarioEntry();
}

class ComentarioListEntry extends ComentarioEntry {
  final ComentarioId id;
  final String texto;

  const ComentarioListEntry({required this.id, required this.texto});
}

typedef ComentarioId = String;

class ComentarioListCargandoEntry extends ComentarioEntry {}
