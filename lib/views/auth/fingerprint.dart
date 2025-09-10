import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:formify/constants/app_colors.dart';
import 'package:formify/constants/app_sizes.dart';
import 'package:formify/generated/assets.dart';
import 'package:formify/views/bottom-navbar/navbar.dart';
import 'package:formify/widget/common_image_view_widget.dart';
import 'package:formify/widget/custom_appbar.dart';
import 'package:formify/widget/my_text_widget.dart';
import 'package:get/get.dart';
class FingerPrintScreen extends StatefulWidget {
  const FingerPrintScreen({super.key});

  @override
  State<FingerPrintScreen> createState() => _FingerPrintScreenState();
}

class _FingerPrintScreenState extends State<FingerPrintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showLeading: true),
      body: ListView(
        padding: AppSizes.DEFAULT,
        children: [
          MyText(
            text: "Fingerprint ID".tr,
            color: kBlack,
            size: 24,
            textAlign: TextAlign.center,
            weight: FontWeight.w700,
          ),
          MyText(
            text: "Place finger on the sensor to confirm your identity.".tr,
            size: 14,
            textAlign: TextAlign.center,
            weight: FontWeight.w400,
            color: kSubText,
            paddingBottom: 160,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Bounce(
                    onTap: () {          Get.offAll(() =>  MainNavigation());},
                    child: CommonImageView(
                      imagePath: Assets.imagesFignerprintScan,
                      height: 100,
                      width: 100,
                    ),
                  ),

                  MyText(
                    text: "Place your finger on the sensor".tr,
                    size: 14,
                    paddingTop: 10,
                    weight: FontWeight.w400,
                    color: kSubText,
                    paddingBottom: 160,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
