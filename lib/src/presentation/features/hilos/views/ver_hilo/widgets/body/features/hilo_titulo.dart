import 'package:flutter/material.dart';

import '../../../../../../../common/widgets/text/titulo_global.dart';


class HiloTituloView extends StatelessWidget {
  final String title;
  const HiloTituloView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(child:TituloGlobal(txt: title, fontSize: 29,fontWeight: FontWeight.w900));
  }
}
