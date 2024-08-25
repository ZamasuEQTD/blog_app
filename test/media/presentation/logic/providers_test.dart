import 'package:blog_app/features/media/presentation/widgets/miniatura/miniatura.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("UrlsProvidersTest", () {
    test("devuelve YTB cuando el dominio es de Yotubue", () {
      final String provider = UrlsDomains.providerFromUrl(
          "https://www.youtube.com/watch?v=85YbMEb1qkQ");

      expect(provider, "YTB");
    });
    test("lanza excepcion cuando no esta registrado provider", () {
      expect(
          () => UrlsDomains.providerFromUrl(
              "https://stackoverflow.com/questions/14211973/get-host-domain-from-url"),
          throwsArgumentError);
    });
  });
}
