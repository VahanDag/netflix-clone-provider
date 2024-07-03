import 'package:flutter/material.dart';
import 'package:movie_app/core/custom_snackbar.dart';
import 'package:movie_app/routers.dart';
import 'package:movie_app/service/firebase_service.dart';
import 'package:movie_app/views/auth/auth_widgets.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ref = context.read<FirebaseService>();
    return AuthFrame(
      isRegisterPage: true,
      formValues: ({required email, name, required password, rePassword}) async {
        final response = await ref.createUser(email, password, name ?? "");
        if (response) {
          customSnackBar(context: context, title: "Welcome", isNegative: false);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Routers()));
        } else {
          customSnackBar(context: context, title: "Something went wrong", isNegative: true);
        }
      },
    );
  }
}
