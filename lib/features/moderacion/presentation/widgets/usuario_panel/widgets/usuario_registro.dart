import 'package:blog_app/features/baneos/domain/ibaneos_repository.dart';
import 'package:blog_app/features/baneos/domain/models/baneo.dart';
import 'package:blog_app/features/baneos/presentation/screens/banear_usuario_screen.dart';
import 'package:blog_app/features/moderacion/domain/models/registro_usuario.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UsuarioRegistro extends StatelessWidget {
  const UsuarioRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    RegistroUsuario usuario = context.read();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ColoredBox(
                color: Colors.white,
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const UsuarioFoto.icono(),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              usuario.nombre,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "Unido desde ${usuario.registradoEn.day}/${usuario.registradoEn.month}/${usuario.registradoEn.year}",
                            ),
                          ],
                        ),
                      ],
                    ).paddingSymmetric(vertical: 20),
                  ),
                ),
              ),
            ),
          ).marginSymmetric(vertical: 15),
        ),
        if (usuario.ultimoBaneo != null)
          RegistroUltimoBaneo(baneo: usuario.ultimoBaneo!),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.pushNamed(
              "banear-usuario",
              pathParameters: {
                "id": usuario.id,
              },
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.error,
              ),
            ),
            child: const Text("Banear usuario"),
          ).paddingSymmetric(horizontal: 10).marginOnly(bottom: 10),
        ),
      ],
    ).sliverBox;
  }
}

class UsuarioRegistroSkeleton extends StatelessWidget {
  const UsuarioRegistroSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const ColoredBox(
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                UsuarioFoto.bone(),
                SizedBox(width: 10),
                Bone.text(
                  words: 4,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).sliverBox;
  }
}

abstract class UsuarioFoto extends StatelessWidget {
  const UsuarioFoto._({super.key});
  const factory UsuarioFoto({required Widget child}) = _UsuarioFoto;

  const factory UsuarioFoto.icono() = _UsuarioFotoIcono;

  const factory UsuarioFoto.bone() = _UsuarioFotoBone;
}

class _UsuarioFoto extends UsuarioFoto {
  final Widget child;
  const _UsuarioFoto({required this.child}) : super._();
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox.square(
        dimension: 70,
        child: child,
      ),
    );
  }
}

class _UsuarioFotoBone extends UsuarioFoto {
  const _UsuarioFotoBone() : super._();
  @override
  Widget build(BuildContext context) {
    return const _UsuarioFoto(child: Bone());
  }
}

class _UsuarioFotoIcono extends UsuarioFoto {
  const _UsuarioFotoIcono() : super._();

  @override
  Widget build(BuildContext context) {
    return const _UsuarioFoto(
      child: Center(
        child: FaIcon(
          FontAwesomeIcons.user,
          size: 35,
        ),
      ),
    );
  }
}

class RegistroUltimoBaneo extends StatelessWidget {
  final Baneo baneo;
  const RegistroUltimoBaneo({required this.baneo, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ultimo baneo"),
            Text("Moderador: ${baneo.moderador}"),
            Text("Razon: ${razones[baneo.razon]!}"),
            Text(
              baneo.finaliza == null
                  ? "Permanente"
                  : "Finaliza en :${baneo.finaliza!.difference(DateTime.now())}",
            ),
            if (baneo.mensaje != null) Text(baneo.mensaje!),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  IBaneosRepository repository = GetIt.I.get();

                  RegistroUsuario usuario = context.read();

                  repository.desbanear(id: usuario.id);
                },
                child: const Text("Desbanear"),
              ),
            ),
          ],
        ).paddingAll(16),
      ),
    ).marginOnly(bottom: 16);
  }
}
