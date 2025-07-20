import 'package:camera_ocr_scanner/CameraScreen.dart';
import 'package:camera_ocr_scanner/routes/Routes.dart';
import 'package:camera_ocr_scanner/ui/Camer_translation_screen.dart';
import 'package:camera_ocr_scanner/view_model/transaltiontext.dart';
import 'package:camera_ocr_scanner/view_model/translationcamera.dart';
import 'package:camera_ocr_scanner/view_model/translationproviderpdf.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/SharedPrefenceService.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefencesService.initialize_SharedPrefence();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TranslationPdfProvider()),
        ChangeNotifierProvider(create: (_) => TranslationProvider()),
        ChangeNotifierProvider(create: (_) => TranslationcameraProvider()),
     //   ChangeNotifierProvider(create: (_) => TaskViewModel()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routerConfig: AppRoutes.router,
    );
  }
}
