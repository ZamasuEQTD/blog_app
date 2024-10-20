
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';


class ControlarTiempoDeReproductorDeVideo extends StatelessWidget {
  const ControlarTiempoDeReproductorDeVideo({super.key});
  
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      child: Row(
        children: [
          Expanded(
               child:Container(
                color: Colors.green,
          )),
          Expanded(
              child: GestureDetector(
                  child: Container(
                    color: Colors.red,
              ))),
        ],
      ),
    );
  }
}