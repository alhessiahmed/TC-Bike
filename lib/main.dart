import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import '../../localization/app_translations.dart';
import '../../screens/app/unknown_screen.dart';
import '../../pref/shared_pref_controller.dart';
import '../../core/routes/get_pages.dart';
import '../../core/routes/routes_manager.dart';
import '../../core/theme/theme_manager.dart';
import '../../database/db_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbController().initDatabase();
  await SharedPrefController().initPreferences();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          textDirection: TextDirection.rtl,
          debugShowCheckedModeBanner: false,
          theme: ThemeManager.light(),
          initialRoute: RoutesManager.launchScreen,
          getPages: getPages,
          unknownRoute: GetPage(
            name: RoutesManager.unknownScreen,
            page: () => const UnknownScreen(),
          ),
          translations: AppTranslations(),
          locale: Locale(SharedPrefController().lang),
          fallbackLocale: const Locale('ar'),
        );
      },
    );
  }
}
