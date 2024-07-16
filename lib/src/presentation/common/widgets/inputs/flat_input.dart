import 'package:flutter/material.dart';

class InputFlatField extends StatelessWidget {
  final Widget? suffix;
  final String? hintText;
  final InputDecorationTheme? decoration;
  final bool obscureText;
  final BorderRadius? borderRadius;
  final int? maxLines;
  final int? minLines;

  final TextEditingController? controller;
  const InputFlatField({
    super.key, 
    this.suffix, 
    this.decoration,
    this.obscureText = false, 
    this.borderRadius, 
    this.hintText, this.maxLines, 
    this.controller, 
    this.minLines, 
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius?? BorderRadius.circular(5),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        minLines: minLines ,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffix,
        ).applyDefaults(decoration?.merge(defaultTheme)?? defaultTheme),
        obscureText: obscureText,
      )
    );
  }


  static const InputDecorationTheme defaultTheme = InputDecorationTheme(
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    filled: true,
  );
}

class FlatInputDecoration extends InputDecoration {
  FlatInputDecoration({
    double borderRadius = 5,
    super.suffixIcon,
    super.hintText
  }):super(
     filled: true,
     contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
     border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ))
    );
}


class RounededFlatInputDecoration extends FlatInputDecoration {
  RounededFlatInputDecoration({
    required super.hintText
  }):super(borderRadius: 15);
}



class BusquedaInputDecoration extends FlatInputDecoration {
    BusquedaInputDecoration({
    required void Function() onTap,
    super.borderRadius,
    super.hintText
  }):super(suffixIcon: IconButton(onPressed: onTap, icon: const Icon(Icons.search_outlined))); 
}  
