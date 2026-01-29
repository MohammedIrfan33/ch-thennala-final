import 'package:flutter/services.dart';
import 'package:chcenterthennala/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CH Centre Thennala',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light, // Forces light mode
      theme: ThemeData.light(), // Light theme
      darkTheme:
          ThemeData.light(), // Ensures dark theme is ignored dark theme is ignored
      navigatorObservers: [routeObserver],
      home: Screensplash(),
    );
  }
}
