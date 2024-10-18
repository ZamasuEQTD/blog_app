// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:blog_app/common/widgets/seleccionable/logic/class/item.dart';
import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';

import '../../../../../../../common/domain/services/horarios_service.dart';
import '../../../../../../../common/widgets/media/widgets/spoiler_media.dart';
import '../../../../../../../common/widgets/tag/tag.dart';
import '../../../../../../media/presentation/widgets/media_box/media_box.dart';
import '../../../../../domain/models/hilo.dart';
import '../../hilo_screen.dart';

class HiloInformacion extends StatelessWidget {
  const HiloInformacion({
    super.key,
    required this.hilo,
  });

  final Hilo hilo;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          color: Color(0xfff5f5f5),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BanderasDeHilo(
                  hilo: hilo,
                ),
                const Subcategoria(subcategoria: "subcategoria"),
                _Subcategoria(hilo: hilo),
                _HiloAccionesRow(hilo: hilo),
                MultiMediaDisplay(
                  media: hilo.portada.spoileable,
                  dimensionableBuilder: (child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: MediaSpoileable(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 400,
                            maxWidth: double.infinity,
                          ),
                          child: child,
                        ),
                      ),
                    );
                  },
                ),
                Text(
                  hilo.titulo,
                  style: const TituloStyle(),
                ),
                //descripcion
                Text(
                  hilo.descripcion,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HiloAccionesRow extends StatelessWidget {
  const _HiloAccionesRow({
    super.key,
    required this.hilo,
  });

  final Hilo hilo;

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    hilo.autor.autor,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  Tag(
                    background: Colors.grey,
                    border: BorderRadius.circular(5),
                    child: SizedBox(
                      height: 17,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: FittedBox(
                          child: Text(
                            hilo.autor.rango,
                            style: const TextStyle(
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
                    HorariosService.diferencia(
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

class _Subcategoria extends StatelessWidget {
  const _Subcategoria({
    super.key,
    required this.hilo,
  });

  final Hilo hilo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                    height: 35,
                    width: 35,
                    child: Image(
                      image: hilo.categoria.imagen.toProvider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  hilo.categoria.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right)),
          ],
        ),
      ),
    );
  }
}

class _BanderasDeHilo extends StatelessWidget {
  static final HashMap<BanderasDeHilo, Widget> _banderas = HashMap.from({
    BanderasDeHilo.dados: const HiloIcon.dados(),
    BanderasDeHilo.encuesta: const HiloIcon.encuesta(),
    BanderasDeHilo.sticky: const HiloIcon.destacado(),
    BanderasDeHilo.idUnico: const HiloIcon.idUnico(),
  });

  const _BanderasDeHilo({
    super.key,
    required this.hilo,
  });

  final Hilo hilo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          const BackButton(),
          ...hilo.banderas.map(
            (bandera) => SizedBox(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: OutlinedIcon(
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: FittedBox(child: _banderas[bandera]!),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TituloStyle extends TextStyle {
  const TituloStyle() : super(fontSize: 29, fontWeight: FontWeight.w900);
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
    return SizedBox(
      width: 35,
      height: 35,
      child: FittedBox(child: child),
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

abstract class HiloIcon extends StatelessWidget {
  const HiloIcon._({super.key});

  const factory HiloIcon.destacado({Color? color}) = _DestacadoIcon;
  const factory HiloIcon.encuesta({Color? color}) = _EncuestaIcon;
  const factory HiloIcon.dados({Color? color}) = _DadosIcon;
  const factory HiloIcon.idUnico({Color? color}) = _IdUnicoIcon;
}

class _DestacadoIcon extends HiloIcon {
  final Color? color;
  const _DestacadoIcon({
    this.color,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return FaIcon(FontAwesomeIcons.thumbtack, color: color);
  }
}

class _DadosIcon extends HiloIcon {
  final Color? color;

  const _DadosIcon({
    this.color,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return FaIcon(
      FontAwesomeIcons.diceFour,
      color: color,
    );
  }
}

class _EncuestaIcon extends HiloIcon {
  final Color? color;

  const _EncuestaIcon({
    this.color,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return FaIcon(
      FontAwesomeIcons.chartSimple,
      color: color,
    );
  }
}

class _IdUnicoIcon extends HiloIcon {
  final Color? color;

  const _IdUnicoIcon({
    this.color,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return FaIcon(
      FontAwesomeIcons.user,
      color: color,
    );
  }
}

abstract class Subcategoria extends StatelessWidget {
  const Subcategoria._({super.key});

  const factory Subcategoria({
    void Function()? onTap,
    Widget? trailing,
    required String subcategoria,
  }) = _Subcategorias;
}

class _SubcategoriaCargando extends Subcategoria {
  const _SubcategoriaCargando({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _Subcategorias extends Subcategoria {
  final Widget? trailing;
  final void Function()? onTap;
  final String subcategoria;

  const _Subcategorias({
    this.trailing,
    this.onTap,
    required this.subcategoria,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child: ItemSeleccionable(
          onTap: onTap,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: const SizedBox(
              height: 35,
              width: 35,
              child: Image(
                image: NetworkImage(
                  "https://ae01.alicdn.com/kf/HTB1.H2xXsnrK1RkHFrdq6xCoFXag/CANDYDOLL-New-Girls-High-end-Jacquard-Dress-Sleeveless-Children-s-Princess-Dress-Black-Printed-Knee-dress.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          titulo: Text(
            subcategoria,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
