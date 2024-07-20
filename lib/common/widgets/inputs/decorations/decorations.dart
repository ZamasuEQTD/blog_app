
import 'package:flutter/material.dart';

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

class BusquedaInputDecoration extends FlatInputDecoration {
    BusquedaInputDecoration({
    required void Function() onTap,
    super.borderRadius,
    super.hintText
  }):super(suffixIcon: IconButton(onPressed: onTap, icon: const Icon(Icons.search_outlined))); 
}  