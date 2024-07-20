import 'dart:io';

abstract class Media<TDatosDeMedia extends DatosDeMedia>{
  final TDatosDeMedia datos;

  const Media({required this.datos});
}

class Video extends Media<DatosDeVideo>{
  Video({required super.datos});
}

class Imagen extends Media<DatosDeImagen> {
  const Imagen({required super.datos});
}

abstract class DatosDeMedia {
  final MediaProvider source;

  const DatosDeMedia({required this.source});
}


class DatosDeVideo extends DatosDeMedia{
  final Imagen? previsualizacion;

  const DatosDeVideo({
    required super.source,
    this.previsualizacion
  });
}

class DatosDeYoutube extends DatosDeMedia {
  final Imagen previsualizacion;

  const DatosDeYoutube({
    required NetworkMediaProvider super.source, 
    required this.previsualizacion
  });
   
  factory DatosDeYoutube.fromUrl({
    required NetworkMediaProvider source
  }){
    return DatosDeYoutube(
    source: source, 
    previsualizacion: Imagen(
      datos: DatosDeImagen(
        source: NetworkMediaProvider(
          url: YoutubeService.getYoutubePrevisualizacionFromUrl(source.url))
        )
      )
    );
  }
}

class YoutubeVideo extends Media<DatosDeYoutube> {
  const YoutubeVideo({required super.datos});
}

class DatosDeImagen extends DatosDeMedia{
  const DatosDeImagen({required super.source});
}

abstract class MediaProvider {
  const MediaProvider();
}

class FileMediaProvider extends MediaProvider {
  final File file;

  const FileMediaProvider({required this.file});
}

class NetworkMediaProvider extends MediaProvider {
  final String url;

  const NetworkMediaProvider({required this.url});
}

class YoutubeService {
  const YoutubeService._();

  static String getYoutubeVideoIdFromUrl(String url) => "";

  static String getYoutubePrevisualizacionFromId(String id) => "";
  
  static String getYoutubePrevisualizacionFromUrl(String url) => "";
}