import 'package:formify/config/theme/app_theme.dart';
import 'package:formify/constants/export.dart';
import 'package:formify/config/theme/theme-cont.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeController.theme.value, 
        debugShowCheckedModeBanner: false,
        initialRoute: AppLinks.splash_screen,
        getPages: AppRoutes.pages,
      );
    });
  }
}
