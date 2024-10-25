import 'package:blog_app/src/lib/features/media/domain/youtube_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("description", () {
    test("description", () {
      String? id = YoutubeService.getVideoId(
        "https://www.youtube.com/watch?v=0hG-2tQtdlE",
      );

      expect(id, "0hG-2tQtdlE");
    });
  });
}
