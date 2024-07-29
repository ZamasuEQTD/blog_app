import 'package:blog_app/common/widgets/button/filled_icon_button.dart';
import 'package:blog_app/common/widgets/effects/blur/blurear_widget.dart';
import 'package:blog_app/domain/features/media/usecases/get_gallery_file_usecase.dart';
import 'package:blog_app/presentation/hilos/views/postear_hilo/logic/bloc/postear_hilo/postear_hilo_bloc.dart';
import 'package:blog_app/presentation/media/widgets/media_box/media_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flash/flash.dart';

class Portada extends StatelessWidget {
  const Portada({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<PostearHiloBloc, PostearHiloState>(
          builder: (context, state) {
            if (state.portada != null) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BlurearMedia(
                    blurear: state.portada!.esSpoiler,
                    onTap: () =>
                        context.read<PostearHiloBloc>().add(SwitchSpoiler()),
                    child: MediaBox(
                      media: state.portada!.spoileable,
                      options: const MediaBoxOptions(),
                    )),
              );
            }
            return const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: AgregarPortadaDesdeEnlace(),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: AgregarPortadaDesdeGaleria(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class AgregarPortadaDesdeGaleria extends StatelessWidget {
  const AgregarPortadaDesdeGaleria({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const RoundedButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xff3779FC))),
        onPressed: () {
          GetGalleryFileUsecase usecase = GetIt.I.get();
          usecase.handle(2).then(
            (value) {
              value.fold((l) {
                SnackbarManager.show(context);
              },
                  (r) => context
                      .read<PostearHiloBloc>()
                      .add(AgregarMedia(media: r)));
            },
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Galeria"),
            SizedBox(width: 10),
            Icon(
              CupertinoIcons.photo,
              size: 30,
            )
          ],
        ));
  }
}

class AgregarPortadaDesdeEnlace extends StatelessWidget {
  const AgregarPortadaDesdeEnlace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const RoundedButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xff3779FC))),
        onPressed: () {},
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enlace", style: TextStyle()),
            SizedBox(width: 5),
            Icon(
              CupertinoIcons.link,
              size: 30,
            )
          ],
        ));
  }
}

class RoundedButtonStyle extends ButtonStyle {
  const RoundedButtonStyle({super.backgroundColor})
      : super(
            elevation: const WidgetStatePropertyAll(0),
            shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
            padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 15, vertical: 10)));
}

class BlurearMedia extends StatelessWidget {
  final Widget child;
  final bool blurear;
  final void Function() onTap;

  const BlurearMedia({
    super.key,
    required this.child,
    required this.blurear,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Blurear(blurear: blurear, child: child),
        Positioned.fill(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.topRight,
            child: ColoredIconButton(
                border: BorderRadius.circular(10),
                onPressed: onTap,
                icon: Icon(
                  blurear ? CupertinoIcons.eye : Icons.reddit,
                  size: 30,
                )),
          ),
        ))
      ],
    );
  }
}

class SnackbarManager extends FlashBar {
  SnackbarManager(
      {super.key,
      required super.controller,
      required String title,
      required Color background})
      : super(content: Text(title), backgroundColor: background);

  static void show(BuildContext context) {
    showFlash(
        context: context,
        builder: (context, controller) {
          return SnackbarManager(
              controller: controller,
              title: "prueba",
              background: Colors.white);
        });
  }
}
