import 'package:formify/constants/export.dart';
import 'package:formify/views/bottom-navbar/navbar.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            Assets.imagesgirlfindingproducts,
            fit: BoxFit.cover,
            cacheWidth: 1080,
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
          ),

          // Foreground Content
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyText(
                      text: 'MarketFit',
                      color: kPrimaryColor,
                      size: 40,
                      weight: FontWeight.bold,
                    ),
                    Gap(10),
                    MyText(
                      text: 'Plan Smarter, Organize Better'.tr,
                      color: kWhite,
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                    Gap(6),
                    MyText(
                      text:
                          'Stay on top of every event, schedule with ease, and never miss a moment.'
                              .tr,
                      color: kWhite,
                      size: 14,
                      weight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                    Gap(30),

                    MyButton(
                      buttonText: 'Get Started',
                      backgroundColor: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      onTap: () {
                        Get.to(
                          MainNavigation(),
                          transition: Transition.rightToLeftWithFade,
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                    ),
                    Gap(60),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
