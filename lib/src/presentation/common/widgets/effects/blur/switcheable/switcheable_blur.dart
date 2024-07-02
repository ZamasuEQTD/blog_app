import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blurear_widget.dart';
import 'logic/bloc/blur_bloc.dart';

class SwitcheableBlurWidget extends StatelessWidget {
  final bool initialValue;
  final Widget child;
  const SwitcheableBlurWidget({super.key, required this.child, this.initialValue = false});

  @override
  Widget build(BuildContext context) {
   return BlocProvider(create: (context) => BlurBloc(initial: initialValue),
    child: BlocBuilder<BlurBloc, BlurState>(builder: (context, state) {
        if(state.blurear) {
          return BlurearWidget(child: child);
        }
        return child;
    })
   );
  }
}