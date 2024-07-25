import 'package:blog_app/common/widgets/inputs/decorations/decorations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Column(
        children: [
          const Text(
            "¡Bienvenido!",
            textAlign: TextAlign.center,
            style: AuthLabelTextStyle(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text("Informacion de la cuenta",textAlign: TextAlign.start,style: TextStyle(fontSize: 15),)
              ),
              TextField(
                decoration: FlatInputDecoration(hintText: "Usuario"),
              ),
              const PasswordField(),
              AuthBtn(
                child: ElevatedButton(
                    onPressed: _onIniciarSesion,
                    child: Text("Iniciar Sesion")
                  )
              )
            ],
          )
        ],
      ),
    );
  }

  void _onIniciarSesion() {}
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ObscureInputBuilder(builder: (context, controller) => TextField(
      decoration: FlatPasswordDecoration(
        hintText: "Contraseña",
        isObscure: controller.obscure,onTap: 
        controller.switchObscure
      )
    ));
  }
}

class AuthBtn extends StatelessWidget {
  final Widget child;
  const AuthBtn({
    super.key, 
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 45,
        child: child,
      ),
    );
  }
}


class ObscureInputController extends ChangeNotifier {
  bool _obscure = false;

  bool get obscure => _obscure;

  void switchObscure() {
    _obscure = !_obscure;
    notifyListeners();
  }
}

class ObscureInputBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ObscureInputController controller) builder;
  const ObscureInputBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ObscureInputController(),
      builder: (context, child) => builder(context,context.watch<ObscureInputController>())
    );
  }
}

 
class AuthLabelTextStyle extends TextStyle  {
  const AuthLabelTextStyle(): super(
    fontSize: 30,
    fontWeight: FontWeight.w700
  );
}