import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'blur_effect.dart';

class ContenidoCensurable extends StatelessWidget {
  final Widget child;
  const ContenidoCensurable({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BlurController(),
      builder: (controller) => Obx(
        () => Stack(
          children: [
            child,
            if (controller.blurear.value)
              Positioned.fill(
                child: BlurEffect(
                  blurear: true,
                  child: ColoredBox(
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: OutlinedButton(
                          onPressed: () => controller.blurear.value = false,
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.white.withOpacity(0.15),
                            ),
                            side: const WidgetStatePropertyAll(
                              BorderSide(width: 0.5, color: Colors.transparent),
                            ),
                            shape: const WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                            ),
                            padding: const WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 30,
                              ),
                            ),
                          ),
                          child: const FittedBox(
                            child: Text(
                              "Ver contenido",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
