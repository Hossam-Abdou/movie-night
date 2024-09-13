import 'package:flutter/material.dart';
import 'package:movie_night/feature/bottom_nav_bar/view/bottom_bar_screen.dart';
import 'package:movie_night/utils/app_images/app_images.dart';


class SplashScreen extends StatefulWidget {
static String routeName = 'splash';

  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
@override
  void initState() {
    super.initState();
  Future.delayed(const Duration(seconds: 3), () {
    Navigator.pushReplacementNamed(context, BottomBarScreen.routeName);
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(AppImages.splash),
          const Spacer(),
          Image.asset(AppImages.slogan),
        ],
      ),
    );
  }
}
