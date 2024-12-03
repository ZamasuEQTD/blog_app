import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
