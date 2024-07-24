import 'dart:io';

import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/data/features/media/abstractions/gallery_media_datasource.dart';
import 'package:blog_app/domain/features/media/entities/media.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerGalleryMediaDatasource extends IGalleryMediaDatasource {
  @override
  Future<Either<Failure, Media>> pick() async {
    var picked = await FilePicker.platform.pickFiles();    

    if(picked != null){
      var media = picked.files[0];

      if(media.xFile.mimeType!.contains("image")) return Right(Imagen(datos: DatosDeImagen(source: FileMediaProvider(file:File(media.xFile.path)))));     

      if(media.xFile.mimeType!.contains("video")) return Right(Video(datos: DatosDeVideo(source: FileMediaProvider(file:File(media.xFile.path)))));    
    }

    throw UnimplementedError();
  }
}