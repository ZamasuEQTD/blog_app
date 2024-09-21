import 'package:blog_app/common/widgets/button/filled_icon_button.dart';
import 'package:flutter/material.dart';

class FlatInputDecoration extends InputDecoration {
  FlatInputDecoration(
      {double borderRadius = 5, super.suffixIcon, super.hintText})
      : super(
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                )));
}

class FlatPasswordDecoration extends FlatInputDecoration {
  final bool isObscure;
  FlatPasswordDecoration(
      {required this.isObscure,
      required void Function() onTap,
      required super.hintText,
      super.borderRadius})
      : super(
            suffixIcon: ColoredIconButton(
                onPressed: onTap,
                icon: Icon(isObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined)));
}

class BusquedaInputDecoration extends FlatInputDecoration {
  final bool tieneTexto;
  BusquedaInputDecoration({
    required void Function() onTap,
    super.borderRadius,
    super.hintText,
    this.tieneTexto = false,
  }) : super(
            suffixIcon: IconButton(
                onPressed: onTap, icon: const Icon(Icons.search_outlined)));
}
