import 'package:flutter/cupertino.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:wago/layout/wago_layout.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: WagoLayout(),
      duration: 4000,
      speed: 1,
      imageSize: 190,
      imageSrc: 'assets/images/splash.png',
    );
  }
}
