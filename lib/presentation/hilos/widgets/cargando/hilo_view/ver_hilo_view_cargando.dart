
import 'package:blog_app/common/widgets/skeleton/skeleton.dart';
import 'package:flutter/material.dart';

class HiloViewCargando extends StatelessWidget {
  const HiloViewCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverMainAxisGroup(slivers: [
          SliverToBoxAdapter(
            child: HiloBodyCargando()
          ),
        ])
      ],
    );
  }
}

 
class HiloBodyCargando extends StatelessWidget {
  const HiloBodyCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _LoadingDataView(),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Skeleton(
            borderRadius: BorderRadius.circular(20),
            height: 30,
            width: 200,
          ),
        )
      ],
    );
  }
}

class _LoadingDataView extends StatelessWidget {
  const _LoadingDataView();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(7),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      child: const SafeArea(
        child: _HiloDataLoading(),
      ),
    );
  }
}

class _HiloDataLoading extends StatelessWidget {
  const _HiloDataLoading();

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _HiloFeaturesBarLoading(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const HiloViewIconsRowLoading(),
                Skeleton(
                  borderRadius: BorderRadius.circular(30),
                  height: 25,
                  width: 60,
                )
              ],
            ),
          ),
          _HiloFeaturesBarLoading(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  _IconHiloLoading(),
                  SizedBox(
                    width: 5,
                  ),
                  _IconHiloLoading(),
                  SizedBox(
                    width: 5,
                  ),
                  _IconHiloLoading()
                ],
              ),
              Row(
                children: [
                  Skeleton(
                    width: 60,
                    borderRadius: BorderRadius.circular(20),
                    height: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Skeleton(
                    width: 60,
                    borderRadius: BorderRadius.circular(20),
                    height: 20,
                  )
                ],
              )
            ],
          )),
          ...[
            const Skeleton(
              height: 220,
              width: 200,
            ),
            const SizedBox(
              height: 5,
            ),
            const Skeleton(
              height: 20,
              width: double.infinity,
            ),
            const SizedBox(
              height: 5,
            ),
            const Skeleton(
              height: 20,
              width: 200,
            ),
            const SizedBox(
              height: 5,
            ),
            const Skeleton(
              height: 14,
              width: double.infinity,
            ),
            const SizedBox(
              height: 5,
            ),
            const Skeleton(
              height: 14,
              width: double.infinity,
            ),
            const SizedBox(
              height: 5,
            ),
            const Skeleton(
              height: 14,
              width: 120,
            )
          ]
        ]);
  }
}

class _HiloFeaturesBarLoading extends StatelessWidget {
  final Widget child;
  const _HiloFeaturesBarLoading({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(bottom: 5),
      child: child,
    );
  }
}

class HiloViewIconsRowLoading extends StatelessWidget {
  const HiloViewIconsRowLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        BackButton(),
        _IconHiloLoading(),
        SizedBox(
          width: 5,
        ),
        _IconHiloLoading(),
        SizedBox(
          width: 5,
        ),
        _IconHiloLoading(),
      ],
    );
  }
}

class _IconHiloLoading extends StatelessWidget {
  const _IconHiloLoading();

  @override
  Widget build(BuildContext context) {
    return const Skeleton(
      height: 30,
      width: 30,
    );
  }
}

class CircleLoadingWidget extends StatelessWidget {
  final double size;
  const CircleLoadingWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: Color.fromRGBO(199, 199, 199, 1)),
    );
  }
}
