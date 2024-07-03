import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions.dart';
import 'package:movie_app/views/auth/register.dart';

class AuthFrame extends StatefulWidget {
  const AuthFrame({
    super.key,
    required this.isRegisterPage,
    required this.formValues,
  });

  final bool isRegisterPage;
  final Function({required String email, required String password, String? rePassword, String? name}) formValues;

  @override
  State<AuthFrame> createState() => _AuthFrameState();
}

class _AuthFrameState extends State<AuthFrame> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _rePasswordController;
  late final TextEditingController _nameController;
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    if (widget.isRegisterPage) {
      _rePasswordController = TextEditingController();
      _nameController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: context.deviceWidth * 0.9,
            child: Form(
              key: _globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(height: 125, "assets/images/netflix.webp"),
                  const SizedBox(height: 40.0),
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  if (widget.isRegisterPage) _registerComponents(),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: context.deviceWidth * 0.75,
                    child: OutlinedButton(
                        style: const ButtonStyle(shape: WidgetStatePropertyAll(ContinuousRectangleBorder())),
                        onPressed: () {
                          if (_globalKey.currentState?.validate() ?? false) {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                            String rePassword = "";
                            String name = "";
                            if (widget.isRegisterPage) {
                              rePassword = _rePasswordController.text.trim();
                              name = _nameController.text.trim();
                            }
                            widget.formValues(email: email, password: password, rePassword: rePassword, name: name);
                          }
                        },
                        child: Text(widget.isRegisterPage ? "SIGN UP" : "SIGN IN")),
                  ),
                  const SizedBox(height: 24.0),
                  if (!widget.isRegisterPage)
                    _goToRegisterPage()
                  else
                    TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: const Text("Back to login"),
                        icon: const Icon(Icons.arrow_back))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _registerComponents() {
    return Column(children: [
      const SizedBox(height: 16.0),
      CustomTextFormField(
        controller: _rePasswordController,
        hintText: 'Confirm Password',
        obscureText: true,
      ),
      const SizedBox(height: 16.0),
      CustomTextFormField(
        controller: _nameController,
        hintText: 'Name',
        obscureText: false,
      ),
    ]);
  }

  Column _goToRegisterPage() {
    return Column(children: [
      TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
        },
        child: const Text(
          'Not a member yet? Start your free month!',
          style: TextStyle(color: Colors.white70),
        ),
      ),
      TextButton(
        onPressed: () {
          // Add your forgot password logic here
        },
        child: const Text(
          'Forgot Your Password?',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    ]);
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Value cannot be empty";
        }
        return null;
      },
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
