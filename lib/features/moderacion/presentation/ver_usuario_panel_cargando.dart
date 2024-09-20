import 'package:blog_app/common/widgets/skeleton/skeleton.dart';
import 'package:flutter/material.dart';

class VerUsuarioPanelCargando extends StatelessWidget {
  const VerUsuarioPanelCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(slivers: [
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: Skeleton(
                    borderRadius: BorderRadius.zero,
                    width: 70,
                    height: 70,
                  ),
                ),
                SizedBox(width: 10),
                Column(children: [
                  Skeleton(
                    width: 500,
                    height: 20,
                  ),
                  Skeleton(
                    width: 300,
                    height: 16,
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
      const SliverToBoxAdapter(
        child: Row(
          children: [
            Skeleton(
              height: 100,
              width: double.infinity,
            ),
            Skeleton(
              height: 100,
              width: double.infinity,
            )
          ],
        ),
      ),
      SliverList.builder(itemBuilder:  (context, index) => Container(
        child: SkeletonBackground(),
      ))
    ]);
  }
}
