import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'get_started_screen.dart';

class Splashscreen extends StatelessWidget {
  final Function toggleTheme;

  const Splashscreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Lottie.asset(
            'assets/animations/last.json',
            repeat: true,
            reverse: true,
            fit: BoxFit.contain,
          ),
        ),
      ),
      nextScreen: GetStartedScreen(toggleTheme: toggleTheme),
      splashIconSize: 500,
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
