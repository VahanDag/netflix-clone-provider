import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/routers.dart';
import 'package:movie_app/service/firebase_service.dart';
import 'package:movie_app/views/auth/login.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    // ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(builder: (context) => const Routers()),
    //       );
    //     }
    //   });
    runSplashAndGetData();
  }

  Future<void> runSplashAndGetData() async {
    final user = await context.read<FirebaseService>().fetchUserData();
    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => user != null ? const Routers() : const LoginPage()));
        }
      },
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/lottie/netflix.json",
          controller: _controller,
          onLoaded: (composition) {
            _controller.duration = composition.duration;
            _controller.forward();
          },
        ),
      ),
    );
  }
}
