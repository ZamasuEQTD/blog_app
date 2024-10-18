import 'package:blog_app/features/auth/presentation/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../../common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import '../../../../../../../common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import '../../../../../../../common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import '../../../../../../media/domain/usecases/get_gallery_file_usecase.dart';
import '../../../../../../media/presentation/logic/bloc/bloc/gestor_de_media_bloc.dart';
import '../../../../logic/bloc/hilo/comentar_hilo/comentar_hilo_bloc.dart';

class ComentarHiloOpciones extends StatelessWidget {
  const ComentarHiloOpciones({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        ...ItemGrupoSliverList.GenerarSlivers([
          GrupoSeleccionable(
            titulo: "Agregar archivo",
            seleccionables: [
              ItemSeleccionableTileList(
                nombre: "Galeria",
                icon: FontAwesomeIcons.image,
                onTap: () {
                  GetGalleryFileUsecase usecase = GetIt.I.get();
                  usecase
                      .handle(const GetGalleryFileRequest(extensions: []))
                      .then(
                    (value) {
                      value.fold((l) => null, (r) {
                        if (r != null) {
                          context
                              .read<GestorDeMediaBloc>()
                              .add(AgregarMedia(media: r));
                        }
                      });
                    },
                  );
                },
              ),
              ItemSeleccionableTileList(
                nombre: "Enlace",
                icon: FontAwesomeIcons.link,
              ),
            ],
          ),
        ]),
      ],
    );
  }

  static void show(BuildContext context) {
    SliverBottomSheet.show(
      context,
      options: const ShowBottomSheetOptions(
        constraints: BoxConstraints(maxHeight: 500),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<ComentarHiloBloc>(),
          ),
          BlocProvider.value(
            value: context.read<GestorDeMediaBloc>(),
          ),
        ],
        child: const SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 5),
          sliver: ComentarHiloOpciones(),
        ),
      ),
    );
  }
}
