import 'package:blog_app/common/widgets/button/filled_icon_button.dart';
import 'package:blog_app/common/widgets/effects/blur/blurear_widget.dart';
import 'package:blog_app/domain/features/media/usecases/get_gallery_file_usecase.dart';
import 'package:blog_app/presentation/hilos/views/postear_hilo/logic/bloc/postear_hilo/postear_hilo_bloc.dart';
import 'package:blog_app/presentation/media/widgets/media_box/media_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        padding: EdgeInsets.all(10),
        child: BlocBuilder<PostearHiloBloc, PostearHiloState>(
          builder: (context, state) {
            if(state.portada != null){
              return BlurearMedia(
                blurear: state.portada!.esSpoiler,
                onTap:() => context.read<PostearHiloBloc>().add(SwitchSpoiler()),
                child: MediaBox(
                  media: state.portada!.spoileable,
                  options: MediaBoxOptions(),
                )
              );
            }
            return Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    
                  }, 
                  child: Text("Agregar desde enlace")
                ),
                ElevatedButton(
                  onPressed: () {
                    GetGalleryFileUsecase usecase = GetIt.I.get();
                    usecase.handle(2).then((value) {
                      value.fold((l) {
                        SnackbarManager.show(context);
                      },
                      (r) => context.read<PostearHiloBloc>().add(
                          AgregarMedia(media: r)
                        )
                      );
                      },
                    );
                  }, 
                  child: Text("Agregar desde galeria")
                )
              ],
            );
          },
        ),
      ),
    );
  }
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
        Blurear(
          blurear: blurear,
          child: child
        ),
        Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                child: ColoredIconButton(
                  onPressed: onTap, 
                  icon: Icon(
                    blurear? CupertinoIcons.eye : Icons.reddit
                  )
                ),
              ),
            )
          )
      ],
    );
  }
}

class SnackbarManager extends FlashBar {
  SnackbarManager({
    super.key,
    required super.controller, 
    required String title,
    required Color background
  }):super(
    content: Text(title),
    backgroundColor: background
  );

  static void show(BuildContext context){
    showFlash(context: context, builder: (context, controller) {
      return SnackbarManager(controller: controller, title: "prueba", background: Colors.white); 
    });
  }
}