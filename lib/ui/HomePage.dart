import 'package:camera_ocr_scanner/constants/App_Colors.dart';
import 'package:camera_ocr_scanner/ui/Camer_translation_screen.dart';
import 'package:camera_ocr_scanner/ui/PdfPage.dart';
import 'package:camera_ocr_scanner/ui/TextTranslate.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> screens = [

    TranslationPage(),
    CameraTranslationPage(),
    PdfTranslationPage(),

  ];

  void setScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BackgroundColor,
      body: screens[_selectedIndex],
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.deepPurple,
        barItems: [
          BarItem(title: "Home", icon: Icons.home),
          BarItem(title: "Camera", icon: Icons.camera),
          BarItem(title: "Add", icon: Icons.picture_as_pdf),
        ],
        selectedIndex: _selectedIndex,
        onButtonPressed: setScreen,
        activeColor: Colors.white,
        inactiveColor: AppColors.inactivecolor,
        iconSize: 30,
      ),
    );
  }
}
