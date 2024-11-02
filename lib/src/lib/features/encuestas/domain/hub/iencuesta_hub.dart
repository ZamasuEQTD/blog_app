import 'dart:async';
import 'dart:math';

import 'package:blog_app/src/lib/features/encuestas/domain/models/encuesta.dart';

abstract class IEncuestaHub {
  Stream<RespuestaId> get onVotoSumado;

  void connect();
  void disconnect();
}

class LocalEncuestaHub extends IEncuestaHub {
  final List<RespuestaId> respuestas;

  final StreamController<RespuestaId> _onVotoSumado =
      StreamController.broadcast();

  LocalEncuestaHub({required this.respuestas});

  @override
  Stream<RespuestaId> get onVotoSumado => _onVotoSumado.stream;

  @override
  void connect() {
    //Timer.periodic(const Duration(seconds: 10), (timer) {
    //  final respuesta =
    //      respuestas.elementAt(Random().nextInt(respuestas.length));
    //  _onVotoSumado.add(respuesta);
    //});
  }

  @override
  void disconnect() {
    _onVotoSumado.close();
  }
}
