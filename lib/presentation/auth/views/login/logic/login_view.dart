import 'package:blog_app/common/widgets/inputs/decorations/decorations.dart';
import 'package:flutter/material.dart';

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
              PasswordField(
                hintText: "Contraseña",
              ),
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


class PasswordField extends StatefulWidget {
  final String hintText;
  const PasswordField({
    super.key, 
    required this.hintText,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final TextEditingController controller = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscure,
      decoration: FlatPasswordDecoration(
        isObscure: isObscure, 
        onTap: _onTap,
        hintText: widget.hintText
      ),
    );
  }

  void _onTap() {
    setState(() {
      isObscure != isObscure;
    });
  }
}

class AuthLabelTextStyle extends TextStyle  {
  const AuthLabelTextStyle(): super(
    fontSize: 30,
    fontWeight: FontWeight.w700
  );
}