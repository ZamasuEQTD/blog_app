import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:blog_app/modules/config/api_config.dart';

class HilosMapper {
  static PortadaHilo fromJson(Map<String, dynamic> json) {
    return PortadaHilo.fromJson(
      {...json},
    );
  }

  static List<PortadaHilo> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map(fromJson).toList();
  }
}
