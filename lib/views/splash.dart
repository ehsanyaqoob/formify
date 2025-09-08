// lib/views/splash/splash.dart
import 'package:formify/controller/splash-cont.dart';
import 'package:formify/constants/export.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController controller = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    // Set initial background color to prevent flash
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: kBlack, // Match your splash background
      systemNavigationBarColor: kBlack, // Match your splash background
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack, // Consistent black background throughout
      body: Obx(() {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          color: kBlack, // Always black background
          child: Stack(
            children: [
              // Centered Fitness-themed logo
              Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: controller.isTime.value ? kPrimaryColor : kBlack,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: controller.isTime.value ? kPrimaryColor : kPrimaryColor,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor.withOpacity(controller.isTime.value ? 0.5 : 0.2),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.shopping_bag, // Fitness icon instead of form icon
                    size: 60,
                    color: controller.isTime.value ? kBlack : kPrimaryColor,
                  ),
                ),
              ),
              
              if (controller.showProgress.value)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 50,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Fitness app tagline
                      MyText(
                        text: "Formify".tr,
                        size: 14,
                        weight: FontWeight.w400,
                        color: kPrimaryColor, // Always use primary color for text
                      ),
                      const Gap(36),
                      
                      // Animated progress indicator
                      Obx(() => SizedBox(
                        width: 30,
                        height: 30,
                        child: CustomPaint(
                          painter: GradientCircularProgressPainter(
                            progress: controller.progressValue.value,
                            gradient: SweepGradient(
                              startAngle: 0.0,
                              endAngle: 4.00,
                              colors: [
                                kPrimaryColor,
                                kPrimaryColor.withOpacity(0.7),
                                kPrimaryColor,
                              ],
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    // Reset system UI to default when leaving splash
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ));
    super.dispose();
  }
}

class GradientCircularProgressPainter extends CustomPainter {
  final double progress;
  final SweepGradient gradient;
  final double strokeWidth;

  GradientCircularProgressPainter({
    required this.progress,
    required this.gradient,
    this.strokeWidth = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    
    double sweepAngle = 2 * 3.141592653589793 * progress;
    canvas.drawArc(rect, -3.141592653589793 / 2, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant GradientCircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}