import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/features/media/domain/abstractions/igallery_service.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:mime/mime.dart';

class FilePickerGalleryService extends IGalleryService {
  final IMediaFactory _factory = GetIt.I.get();
  @override
  Future<Either<Failure, Media?>> pickFile(
      {required List<String> extensions}) async {
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
  Future<Either<Failure, List<Media>>> pickFiles(
      {required List<String> extensions, int cantidad = 1}) async {
    var picked = await FilePicker.platform.pickFiles(
        allowedExtensions: extensions.isEmpty ? null : extensions,
        allowMultiple: cantidad > 1);

    if (picked == null) return const Right([]);

    List<Media> medias = [];

    for (var pick in picked.files) {
      medias.add(_factory.create(pick.path!));
    }

    return Right(medias);
  }
}

abstract class IMediaFactory {
  Media create(String path);
}

class MediaFactory extends IMediaFactory {
  @override
  Media create(String path) {
    final String mime = MimeHelper.getMime(path);
    if (mime.contains("video")) {
      return Video(provider: FileProvider(path: path));
    }

    if (mime.contains("image")) {
      return Imagen(provider: FileProvider(path: path));
    }

    throw ArgumentError("");
  }
}

class MimeHelper {
  const MimeHelper._();
  static String getMime(String path) => lookupMimeType(path)!;
}
