class ApiConfig {
  const ApiConfig._();

  static const String baseUrl = "http://192.168.2.105:5179";

  static const String staticContent = "$baseUrl/static/";

  static const String media = baseUrl;

  static const String api = "$baseUrl/api";
}
