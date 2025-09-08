import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formify/config/theme/theme-cont.dart';
import 'package:formify/constants/app_colors.dart';
import 'package:formify/generated/assets.dart';
import 'package:formify/views/home/booking-screen.dart';
import 'package:formify/views/home/home-screen.dart';
import 'package:formify/views/home/notification-screen.dart';
import 'package:formify/views/home/profile-screen.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  var currentIndex = 0.obs;
  void changeTab(int index) => currentIndex.value = index;
}

class MainNavigation extends StatelessWidget {
  MainNavigation({super.key});

  final NavController navController = Get.put(NavController());

  final List<Widget> _pages = [
    HomeScreen(),
    BookingScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeController = Get.find<ThemeController>();
      final bool isDarkMode = themeController.isDarkMode;

      return CupertinoPageScaffold(
        backgroundColor: isDarkMode ? kBlack : kWhite,
        child: Stack(
          children: [
            Obx(
              () => AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _pages[navController.currentIndex.value],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60.0,
                margin: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 24,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: isDarkMode ? kSecondaryColorDark : kWhite,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SvgNavBarItem(
                        iconPath: Assets.imagesHome,
                        isSelected: navController.currentIndex.value == 0,
                        onTap: () => navController.changeTab(0),
                        isDarkMode: isDarkMode,
                      ),
                      _SvgNavBarItem(
                        iconPath: Assets.imagesHome,
                        isSelected: navController.currentIndex.value == 1,
                        onTap: () => navController.changeTab(1),
                        isDarkMode: isDarkMode,
                      ),
                      _SvgNavBarItem(
                        iconPath: Assets.imagesHome,
                        isSelected: navController.currentIndex.value == 2,
                        onTap: () => navController.changeTab(2),
                        isDarkMode: isDarkMode,
                      ),
                      _AvatarNavItem(
                        imagePath: Assets.imagesHome,
                        isSelected: navController.currentIndex.value == 3,
                        onTap: () => navController.changeTab(3),
                        isDarkMode: isDarkMode,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _SvgNavBarItem extends StatefulWidget {
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDarkMode;

  const _SvgNavBarItem({
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  State<_SvgNavBarItem> createState() => _SvgNavBarItemState();
}

class _SvgNavBarItemState extends State<_SvgNavBarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: widget.isSelected ? 1.2 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          padding: widget.isSelected
              ? const EdgeInsets.all(10)
              : EdgeInsets.zero,
          decoration: widget.isSelected
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.isDarkMode ? kPrimaryColorDark : kPrimaryColor3,
                )
              : null,
          child: Image.asset(
            widget.iconPath,
            width: 22,
            height: 22,
            color: widget.isSelected
                ? kWhite
                : widget.isDarkMode
                ? kGreyColor3
                : kGreyColor,
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class _AvatarNavItem extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDarkMode;

  const _AvatarNavItem({
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.15 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? (isDarkMode ? kPrimaryColorDark : kPrimaryColor)
                : Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? (isDarkMode ? kPrimaryColorDark : kPrimaryColor)
                  : (isDarkMode ? kGreyColor3 : kGreyColor),
              width: isSelected ? 0 : 1,
            ),
          ),
          child: CircleAvatar(
            radius: 14,
            backgroundColor: isDarkMode
                ? kSecondaryColor2Dark
                : kSecondaryColor3,
            backgroundImage: AssetImage(imagePath),
          ),
        ),
      ),
    );
  }
}
