import 'package:formify/constants/export.dart';
import 'package:get/get.dart';

class InitialController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  final List<Map<String, String>> onboardingData = [
  {
    'title': 'Effortless Event\nManagement',
    'subtitle': 'From daily meetings to special occasions, organize your schedule with elegant simplicity and precision.',
  },
  {
    'title': 'Seamless Calendar\nExperience',
    'subtitle': 'Navigate your events with intuitive gestures and beautiful visuals designed for effortless planning.',
  },
  {
    'title': 'Smart Event\nOrganization',
    'subtitle': 'Quickly create, edit, and track events with our clean interface and intelligent scheduling features.',
  },
];
  void nextPage() {
    if (currentPage.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to login/signup screen
      Get.toNamed('/auth'); // Replace with your actual route
    }
  }

  void skipOnboarding() {
    Get.toNamed('/auth'); // Replace with your actual route
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}