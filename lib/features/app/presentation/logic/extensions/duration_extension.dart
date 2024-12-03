extension DurationExtensions on Duration {
  String get tiempoTranscurrido {
    if (inDays > 30) return "${inDays ~/ 30} meses";

    if (inDays > 0) return "$inDays días";

    if (inHours > 0) return "$inHours horas";

    if (inMinutes > 0) return "$inMinutes minutos";

    if (inSeconds > 30) return "$inSeconds segundos";

    return "ahora";
  }
}
