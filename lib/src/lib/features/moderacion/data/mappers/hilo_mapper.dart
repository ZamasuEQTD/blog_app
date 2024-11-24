import 'package:blog_app/src/lib/features/app/api_config.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';

class HilosMapper {
  static Portada fromJson(Map<String, dynamic> json) {
    return Portada.fromJson(
      {...json, "miniatura": ApiConfig.api + json["miniatura"]},
    );
  }

  static List<Portada> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map(fromJson).toList();
  }
}
