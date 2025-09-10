import 'package:flutter/material.dart';
import 'package:formify/constants/export.dart';
import 'package:formify/views/auth/authscreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final PageController _pageController = PageController();
  final PageController _bottomPageController = PageController();
  int _currentPage = 0;
  
final List<Map<String, String>> onboardingData = [
  {
    'title': 'Smart Scheduling\nMade For You',
    'description':
        'From daily meetings to special events, manage your calendar with intuitive tools designed for your busy lifestyle.',
    'image': '',
  },
  {
    'title': 'Personalized Calendar\nJust For You',
    'description':
        'Experience events and reminders tailored to your unique schedule preferences and organizational style.',
    'image': '',
  },
  {
    'title': 'Seamless Event \nJust For You',
    'description':
        'Enjoy a smooth, effortless journey from creating events to tracking your daily schedule with elegant simplicity.',
    'image': '',
  },
];
  @override
  void initState() {
    super.initState();
    // Sync both page controllers
    _pageController.addListener(_syncPageView);
  }

  void _syncPageView() {
    if (_pageController.page != _currentPage) {
      _bottomPageController.animateToPage(
        _pageController.page!.round(),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_syncPageView);
    _pageController.dispose();
    _bottomPageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.to(Authscreen(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500)
      );
      }
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      onboardingData.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: MyText(
                  text: 'Formify',
                  size: 40,
                  weight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
              const Gap(30),
              
              // Main content area with PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingData.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // You can add images or illustrations here for each slide
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: kWhite.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.shopping_bag,
                            size: 100,
                            color: kWhite,
                          ),
                        ),
                     
                      ],
                    );
                  },
                ),
              ),
              
              const Gap(30),
              Align(
                alignment: Alignment.center,
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: onboardingData.length,
                  effect: WormEffect(
                    dotHeight: 6,
                    dotWidth: 16.0,
                    activeDotColor: kWhite,
                    dotColor: kWhite.withOpacity(0.5),
                  ),
                  onDotClicked: (index) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
              const Gap(30),
              
              // Bottom container with PageView for text content
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: PageView.builder(
                  controller: _bottomPageController,
                  physics: const NeverScrollableScrollPhysics(), // Disable manual scrolling
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          MyText(
                            textAlign: TextAlign.center,
                            text: onboardingData[index]['title']!,
                            size: 30,
                            weight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                          const Gap(10),
                          MyText(
                            textAlign: TextAlign.center,
                            text: onboardingData[index]['description']!,
                            size: 16,
                            weight: FontWeight.normal,
                            color: kSubText,
                          ),
                          const Gap(20),
                          MyButton(
                            buttonText: _currentPage == onboardingData.length - 1 
                                ? 'Get Started' 
                                : 'Next',
                            onTap: _nextPage,
                          ),
                          
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}