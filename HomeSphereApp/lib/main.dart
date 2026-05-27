import '/config/constants.dart';
import '/welcome.dart';
import '/home.dart';
import 'splash.dart';
import '/translation/translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const Splash(),
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      theme: ThemeData(
        primaryColor: MyColors.darkThree,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: MyColors.grassyGreen,
        ),
      ),
      getPages: [
        GetPage(name: '/splash', page: () => const Splash()),
        // HOME
        GetPage(name: '/home', page: () => const Home()),
        GetPage(name: '/welcome', page: () => const Welcome()),
      ],
    );
  }
}
