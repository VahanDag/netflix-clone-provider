import 'package:flutter/material.dart';
import 'package:movie_app/views/auth/auth_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthFrame(
      isRegisterPage: false,
      formValues: ({required email, name, required password, rePassword}) {
        print(email);
        print(password);
      },
    );
  }
}
