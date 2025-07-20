import 'package:camera_ocr_scanner/constants/App_Colors.dart';
import 'package:camera_ocr_scanner/routes/Route_Name.dart';
import 'package:camera_ocr_scanner/services/NavigatorServices.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      NavigatorServices.GoTo(RoutesName.signup_route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Darkcolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'TRANSLATOR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Translate thoughts. Connect hearts.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 15,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
