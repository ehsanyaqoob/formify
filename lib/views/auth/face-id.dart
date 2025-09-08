import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:formify/constants/app_colors.dart';
import 'package:formify/generated/assets.dart';
import 'package:formify/widget/common_image_view_widget.dart';
import 'package:formify/widget/my_text_widget.dart';
import 'package:get/get.dart';

class FaceIDScreen extends StatefulWidget {
  const FaceIDScreen({super.key});

  @override
  State<FaceIDScreen> createState() => _FaceIDScreenState();
}

class _FaceIDScreenState extends State<FaceIDScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(Assets.imagesFacebg, fit: BoxFit.fill),
            ),

            // Overlay image
            Positioned.fill(
              child: CommonImageView(
                imagePath: Assets.imagesSubtractFaceId,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 50,
              left: 20,

              child: Bounce(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back_rounded, color: kWhite),
              ),
            ),

            // Foreground Text
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  MyText(
                    text: "Face ID".tr,
                    size: 24,
                    paddingBottom: 10,
                    textAlign: TextAlign.center,
                    weight: FontWeight.w700,
                  ),

                  MyText(
                    text: "Put your face in the oval shape below".tr,
                    size: 14,
                    textAlign: TextAlign.center,
                    weight: FontWeight.w300,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
