import 'package:blog_app/features/app/clases/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:mime/mime.dart';

import '../domain/abstractions/igallery_service.dart';
import '../domain/models/media.dart';

class FilePickerGalleryService extends IGalleryService {
  final IMediaServiceFactory _factory = GetIt.I.get();

  @override
  Future<Either<Failure, Media?>> pickFile({
    required List<String> extensions,
  }) async {
    var result = await pickFiles(extensions: extensions, cantidad: 1);

    Media? media;

    result.fold((l) {}, (r) {
      if (r.isEmpty) {
        return;
      }
      media = r[0];
    });

    return Right(media);
  }

  @override
  Future<Either<Failure, List<Media>>> pickFiles({
    required List<String> extensions,
    int cantidad = 1,
  }) async {
    var picked = await FilePicker.platform.pickFiles(
      allowedExtensions: extensions.isEmpty ? null : extensions,
      allowMultiple: cantidad > 1,
    );

    if (picked == null) return const Right([]);

    List<Media> medias = [];

    for (var pick in picked.files) {
      IFilePicked file = FilePicked(pick);

      medias.add(
        await _factory.create(file.mime).fromFile(file.path),
      );
    }

    return Right(medias);
  }
}

class MimeService {
  static String getMime(String path) => lookupMimeType(path)!;
}

abstract class IFilePicked {
  String get path;
  String get mime;
}

class FilePicked extends IFilePicked {
  final PlatformFile file;

  FilePicked(this.file);

  @override
  String get mime => MimeService.getMime(path).split("/")[0];

  @override
  String get path => file.path!;
}

abstract class IMediaServiceFactory {
  IMediaService create(String mime);
}

abstract class IMediaService {
  Future<Media> fromFile(String path);
}

class GetItMediaServiceFactory implements IMediaServiceFactory {
  @override
  IMediaService create(String mime) {
    switch (mime) {
      case "video":
        return GetIt.I.get<VideoFactory>();
      case "image":
        return GetIt.I.get<ImagenFactory>();
    }

    throw Exception("Tipo de media no soportado");
  }
}

class VideoFactory extends IMediaService {
  @override
  Future<Media> fromFile(String path) {
    return Future.value(Video(provider: FileProvider(path: path)));
  }
}

class ImagenFactory extends IMediaService {
  @override
  Future<Media> fromFile(String path) {
    return Future.value(Imagen(provider: FileProvider(path: path)));
  }
}
