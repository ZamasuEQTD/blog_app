import 'package:blog_app/features/media/domain/usecases/generar_miniatura_usecase.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnailService extends IMiniaturaService {
  @override
  Future<String> generar(String video) async {
    return (await VideoThumbnail.thumbnailFile(video: video))!;
  }
}
