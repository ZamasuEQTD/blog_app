import 'fuente_de_archivo.dart';
abstract class Media {
  final FuenteDeArchivo fuente;
  const Media(this.fuente);
}

class Video extends Media {
  final Imagen? previsualizacion;
  const Video(super.fuente,[this.previsualizacion] );

  Video copyWith({
    Imagen? previsualizacion,
    FuenteDeArchivo? fuente
  }){
    return Video(
      fuente??this.fuente,
      previsualizacion??this.previsualizacion
    );
  }
}

class Imagen extends Media {
  Imagen(super.fuente);
}

class Audio extends Media {
  Audio(super.fuente);
}
class Documento extends Media {
  Documento(super.fuente);
}


