import 'package:blog_app/common/widgets/skeleton/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePortadaCargando extends StatelessWidget {
  const HomePortadaCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: const Stack(
        children: [
          SkeletonBackground(),
          Positioned.fill(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Skeleton(
                      height: 22,
                      width: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Skeleton(
                      height: 22,
                      width: 70,
                    )
                  ],
                ),
                Skeleton(
                  height: 22,
                  width: double.infinity,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
