import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/domain/abstractions/istrategy_context.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:mime/mime.dart';

import '../domain/abstractions/igallery_service.dart';
import '../domain/models/media.dart';

class FilePickerGalleryService extends IGalleryService {
  final IStrategyContext context = GetIt.I.get();
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
        await context.execute<String, Media, IMediaFromFileStrategy>(
          file.mime,
          file.path,
        ),
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

abstract class IMediaFromFileStrategy extends IStrategy<String, Media> {}

class VideoStrategy extends IMediaFromFileStrategy {
  @override
  Future<Media> execute(String input) {
    return Future.value(Video(provider: FileProvider(path: input)));
  }
}

class ImagenStrategy extends IMediaFromFileStrategy {
  @override
  Future<Media> execute(String input) {
    return Future.value(Imagen(provider: FileProvider(path: input)));
  }
}
