// lib/controllers/splash_cont.dart
import 'dart:async';

import 'package:formify/config/routes/routes.dart';
import 'package:formify/views/auth/authscreen.dart';
import 'package:formify/views/intial.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  RxBool isTime = false.obs;
  RxBool showProgress = false.obs;
  RxDouble progressValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    startSplashSequence();
  }

  void startSplashSequence() {
    // First part: wait 4 seconds then change UI state
    Future.delayed(const Duration(seconds: 2), () {
      isTime.value = true;
      showProgress.value = true;
      startProgressAnimation();
    });
  }

  void startProgressAnimation() {
    const totalDuration = Duration(seconds: 2);
    const interval = Duration(milliseconds: 16); // ~60 FPS

    var elapsed = Duration.zero;

    // Animate progress manually
    Timer.periodic(interval, (timer) {
      elapsed += interval;

      if (elapsed >= totalDuration) {
        timer.cancel();
        progressValue.value = 1.0;
        navigateToNextScreen();
      } else {
        progressValue.value =
            elapsed.inMilliseconds / totalDuration.inMilliseconds;
      }
    });
  }

  void navigateToNextScreen() {
    Get.to(Authscreen());
  }
}
