import 'package:formify/constants/export.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({
    super.key,
    this.hasseeall = true,
    this.title,
    this.ontap,
    this.img,
  });
  final bool? hasseeall;
  final VoidCallback? ontap;
  final String? title;
  final String? img;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            MyText(
              text: title ?? '',
              color: kBlack,
              size: 16,
              paddingRight: 10,
              weight: FontWeight.bold,
            ),
            CommonImageView(imagePath: img, height: 18),
          ],
        ),
        if (hasseeall == true)
          Bounce(
            onTap: ontap,
            child: MyText(
              text: "See all".tr,
              color: kPrimaryColor,
              size: 14,
              weight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}

class TitleRow2 extends StatelessWidget {
  const TitleRow2({
    super.key,
    this.hasseeall = true,
    this.title,
    this.ontap,
    this.img,
  });
  final bool? hasseeall;
  final VoidCallback? ontap;
  final String? title;
  final String? img;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (hasseeall == true)
          Bounce(
            onTap: ontap,
            child: MyText(
              text: "See all".tr,
              color: kPrimaryColor,
              size: 14,
              weight: FontWeight.w600,
            ),
          ),
        Row(
          children: [
            MyText(
              text: title ?? '',
              color: kBlack,
              size: 16,
              paddingRight: 10,
              weight: FontWeight.bold,
            ),
            CommonImageView(imagePath: img, height: 18),
          ],
        ),
      ],
    );
  }
}

class LanguageAwareTitleRow extends StatelessWidget {
  const LanguageAwareTitleRow({
    super.key,
    this.hasseeall = true,
    this.title,
    this.ontap,
    this.img,
  });

  final bool? hasseeall;
  final VoidCallback? ontap;
  final String? title;
  final String? img;

  @override
  Widget build(BuildContext context) {
    // Get the current locale
    final currentLocale = Get.locale?.languageCode ?? 'ar';

    // Show TitleRow for Arabic (ar) and TitleRow2 for English (en)
    if (currentLocale == 'en') {
      return TitleRow(
        hasseeall: hasseeall,
        title: title,
        ontap: ontap,
        img: img,
      );
    } else {
      return TitleRow2(
        hasseeall: hasseeall,
        title: title,
        ontap: ontap,
        img: img,
      );
    }
  }
}
