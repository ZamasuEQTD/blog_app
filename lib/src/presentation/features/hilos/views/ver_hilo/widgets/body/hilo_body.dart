 
import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';
import '../../../../../../../domain/features/hilos/models/hilo.dart';
import '../../../../../../../domain/features/media/models/fuente_de_archivo.dart';
import '../../../../../../../domain/features/media/models/media.dart';
import '../../../../../media/widgets/media_box/media_box.dart';
import '../../../../../media/widgets/reproductor_de_video/reproductor_de_video.dart';
import 'features/actions_bar/acciones_de_hilo_bar.dart';
import 'features/hilo_descripcion.dart';
import 'features/hilo_titulo.dart';
import 'features/icons/hilo_body_features_icons.dart';

class HiloBody extends StatelessWidget {
  final Hilo hilo;
  const HiloBody({super.key, required this.hilo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(7),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HiloIconsFeaturesBar(banderas: hilo.banderas),
              const CategoriaDeHiloBar(),
              AccionesDeHiloBar(hilo: hilo),
              MediaDeHilo(hilo: hilo),
              HiloTituloView(
                title: hilo.titulo,
              ),
              HiloDescripcion(
                descripcion: hilo.descripcion,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriaDeHiloBar extends StatelessWidget {
  const CategoriaDeHiloBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(bottom: 5),
      child:  Container()
    );
  }
}

class MediaDeHilo extends StatelessWidget {
  const MediaDeHilo({
    super.key,
    required this.hilo,
  });

  final Hilo hilo;

  @override
  Widget build(BuildContext context) {
    return MediaBox(media: hilo.archivo.spoileable, options: const MediaBoxOptions(
      borderRadius: 10,
      constraints: BoxConstraints(
        maxHeight: 350,
        maxWidth: double.infinity
      )
    ));
  }
}



class PruebaDeVideo extends StatelessWidget {
  const PruebaDeVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log("message");
      },
      child: Container(
        height: 100,
        width: 300,
        color: Colors.red,
        child: Stack(
          children: [
            Container(
              color: Colors.amber,
              child: Row(
                children: [
                  Expanded(child:GestureDetector(
                    onDoubleTap: () {
                      log("holanda");
                  },
                  child: Container(color: Colors.red,))),
                  Expanded(child: Container(color: Colors.grey))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class ControlesDeVideoCustom extends StatelessWidget {
  const ControlesDeVideoCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



// class EncuestaDeHilo extends StatefulWidget {
//   final Encuesta encuesta;
//   const EncuestaDeHilo({
//     super.key,
//     required this.encuesta,
//   });

//   @override
//   State<EncuestaDeHilo> createState() => _EncuestaDeHiloState();
// }

// class _EncuestaDeHiloState extends State<EncuestaDeHilo> {
//   late final EncuestaBloc encuestaBloc;

//   @override
//   void initState() {
//     super.initState();
//     encuestaBloc = EncuestaBloc(
//         encuesta: widget.encuesta,
//         votarEncuestaUseCase: GetItLocator.locator());
//     // ISocketRepository repository = GetItLocator.locator();
//     // repository.subscribirseEncuesta(widget.encuesta.id);

//     // repository.onEncuestaVotada((id) {
//     //   encuestaBloc.add(SumarVoto(id: id));
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       child: BlocProvider.value(
//         value: encuestaBloc,
//         child: const EncuestaWidget(),
//       ),
//     );
//   }
// }

 