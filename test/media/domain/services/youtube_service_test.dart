import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("description", () {
    test("description", () {
      String id = YoutubeService.getVideoId(
          "https://www.youtube.com/watch?v=0hG-2tQtdlE");

      expect(id, "0hG-2tQtdlE");
    });
  });
}
