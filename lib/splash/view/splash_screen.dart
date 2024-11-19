
import 'package:fake_store_v2/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    navigateToNextScreen();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/splash.json',
              frameRate: const FrameRate(200),
              width: 350,
              height: 350,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
  Future<void> navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    AppRoute().navigateToPageList(context);
  }
}
