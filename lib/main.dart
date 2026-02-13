import 'package:chcenterthennala/Appcore/close_challenge_check.dart';
import 'package:flutter/services.dart';
import 'package:chcenterthennala/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();

  await loadCloseChallenge();
  
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



  Widget build(BuildContext context) {
  return ScreenUtilInit(
    designSize: const Size(411.42857142857144,911.2380952380952 ),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return GetMaterialApp(
        title: 'CH Centre Thennala',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData.light(),
        darkTheme: ThemeData.light(),
        navigatorObservers: [routeObserver],
        home: Screensplash(),
      );
    },
  );
}

}
