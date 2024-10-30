import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/domain/services/horario_service.dart';
import '../../../app/presentation/widgets/tag.dart';
import '../../domain/models/hilo.dart';

class HiloAccionesRow extends StatelessWidget {
  const HiloAccionesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Hilo hilo = context.read();

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  HiloAccionDeUsuario.ocultar(),
                  HiloAccionDeUsuario.seguir(),
                  HiloAccionDeUsuario.denunciar(),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Godubi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  Tag(
                    background: Colors.grey,
                    border: BorderRadius.circular(5),
                    child: const SizedBox(
                      height: 17,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: FittedBox(
                          child: Text(
                            "MOD",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    HorarioService.diferencia(
                      utcNow: DateTime.now().toUtc(),
                      time: hilo.creadoEn,
                    ).toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

abstract class HiloAccionDeUsuario extends StatelessWidget {
  const HiloAccionDeUsuario._({super.key});

  const factory HiloAccionDeUsuario({
    required Widget child,
    Key? key,
    required void Function() onTap,
  }) = _HiloAccionDeUsuario;

  const factory HiloAccionDeUsuario.seguir() = _SeguirHilo;

  const factory HiloAccionDeUsuario.ocultar() = _OcultarHilo;

  const factory HiloAccionDeUsuario.denunciar() = _DenunciarHilo;
}

class _HiloAccionDeUsuario extends HiloAccionDeUsuario {
  final void Function() onTap;
  final Widget child;

  const _HiloAccionDeUsuario({
    super.key,
    required this.onTap,
    required this.child,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: SizedBox(
        width: 35,
        height: 35,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: FittedBox(child: child),
        ),
      ),
    );
  }
}

class _DenunciarHilo extends HiloAccionDeUsuario {
  const _DenunciarHilo() : super._();
  @override
  Widget build(BuildContext context) {
    return HiloAccionDeUsuario(
      onTap: () {},
      child: const Icon(Icons.flag_outlined),
    );
  }
}

class _SeguirHilo extends HiloAccionDeUsuario {
  const _SeguirHilo() : super._();

  @override
  Widget build(BuildContext context) {
    return HiloAccionDeUsuario(
      onTap: () {},
      child: const Icon(Icons.flag_outlined),
    );
  }
}

class _OcultarHilo extends HiloAccionDeUsuario {
  const _OcultarHilo() : super._();

  @override
  Widget build(BuildContext context) {
    return HiloAccionDeUsuario(
      onTap: () {},
      child: const Icon(Icons.remove_red_eye),
    );
  }
}
