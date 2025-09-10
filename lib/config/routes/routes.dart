import 'package:formify/constants/export.dart';
import 'package:formify/views/splash.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: AppLinks.splash_screen, page: () => SplashScreen()),
  ];
}

class AppLinks {
  static const splash_screen = '/splash_screen';
}
