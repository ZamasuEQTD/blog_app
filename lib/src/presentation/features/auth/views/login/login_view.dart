import 'package:blog_app/src/presentation/common/widgets/buttons/flat_button.dart';
import 'package:blog_app/src/presentation/common/widgets/inputs/flat_input.dart';
import 'package:blog_app/src/presentation/features/auth/common/widgets/auth_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../common/widgets/password_input.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(CupertinoIcons.chevron_back)
        ),
      ),
      body: LoginBody()
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthLabel(text: "¡Bienvenido!"),
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text("Informacion de la cuenta",textAlign: TextAlign.start,style: TextStyle(fontSize: 15),)),
          InputFlatField(hintText: "Usuario"),
          SizedBox(height: 5),
          PasswordFlatInput(),
          SizedBox(height: 40),
          ],
        ),
        SizedBox(
          height: 45,
          child: FlatBtn.text(
            txt: "Iniciar sesión",
            backgroundColor: Color(0xff5856D6),
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),
            borderRadius: 5,
          ),
        )
      ],
          ),
    );
  }
}

