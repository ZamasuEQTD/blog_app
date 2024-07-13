import 'package:blog_app/src/presentation/common/widgets/skeleton/skeleton.dart';
import 'package:flutter/material.dart';

class PortadaDeHiloHomeCargando extends StatelessWidget {

   const PortadaDeHiloHomeCargando({
    super.key, 
   });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Skeleton(),
      Positioned.fill(
          child: Container(
        padding: const EdgeInsets.all(8),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Skeleton.white(
                  height: 22,
                  width: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Skeleton.white(
                  height: 22,
                  width: 70,
                )
              ],
            ),
            Skeleton.white(
              height: 22,
              width: double.infinity,
            )
          ],
        ),
      ))
    ]);
  }
}
