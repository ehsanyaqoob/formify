import 'package:formify/constants/export.dart';
import 'package:formify/views/events/events-screen.dart';
import 'package:formify/views/home/home-screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    EventsScreen(),
    HomeScreen(),
    const SizedBox.shrink(), // Placeholder for FAB
    HomeScreen(),
    HomeScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) return; // FAB tap handled separately
    setState(() => _currentIndex = index);
  }

  Widget _buildSvgIcon(int index, String activeIcon, String inactiveIcon) {
    final isActive = _currentIndex == index;
    return SvgPicture.asset(
      isActive ? activeIcon : inactiveIcon,
      width: 26,
      height: 26,
      color: kWhite,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double fabSize = 56;
    final double navBarHeight = 65;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 1. Screen content
          _pages[_currentIndex],

          // 2. Nav bar with curve
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: _NavBarClipper(fabRadius: fabSize / 2, notchMargin: 8),
              child: Container(
                height: navBarHeight,
                color: kPrimaryColor.withOpacity(0.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Home Icon
                    GestureDetector(
                      onTap: () => _onItemTapped(0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildSvgIcon(0, Assets.Imageshomesvg, Assets.Imageshomesvg),
                          const SizedBox(height: 4),
                          Container(
                            height: 2,
                            width: 26,
                            color: _currentIndex == 0 ? kWhite : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    // Calendar Icon
                    GestureDetector(
                      onTap: () => _onItemTapped(1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildSvgIcon(1, Assets.Imagescalendarsvg, Assets.Imagescalendarsvg),
                          const SizedBox(height: 4),
                          Container(
                            height: 2,
                            width: 26,
                            color: _currentIndex == 1 ? kWhite : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                   // SizedBox(width: fabSize), // Space for FAB

                    // Notification Icon with badge
                    GestureDetector(
                      onTap: () => _onItemTapped(3),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              _buildSvgIcon(3, Assets.Imagesnotificatiosvg, Assets.Imagesnotificatiosvg),
                              Positioned(
                                right: -4,
                                top: -4,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '5', // number of notifications
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 2,
                            width: 26,
                            color: _currentIndex == 3 ? kWhite : Colors.transparent,
                          ),
                        ],
                      ),
                    ),

                    // Profile Icon
                    GestureDetector(
                      onTap: () => _onItemTapped(4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildSvgIcon(4, Assets.Imagesprofilesvg, Assets.Imagesprofilesvg),
                          const SizedBox(height: 4),
                          Container(
                            height: 2,
                            width: 26,
                            color: _currentIndex == 4 ? kWhite : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 3. Floating FAB above nav bar
          Positioned(
            bottom: navBarHeight / 1.2, // float above the curve
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                height: fabSize,
                width: fabSize,
                child: FloatingActionButton(
                  onPressed: () => _onItemTapped(2),
                  backgroundColor: kWhite, // Solid white background
                  elevation: 6,
                  child: SvgPicture.asset(
                    Assets.Imagesaddsvg,
                    width: 36,
                    height: 36,
                    color: kPrimaryColor, // Primary color icon
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarClipper extends CustomClipper<Path> {
  final double fabRadius;
  final double notchMargin;

  _NavBarClipper({required this.fabRadius, this.notchMargin = 8});

  @override
  Path getClip(Size size) {
    final path = Path();
    final centerX = size.width / 2;
    final radius = fabRadius + notchMargin;

    path.moveTo(0, 0);
    path.lineTo(centerX - radius, 0);
    path.quadraticBezierTo(centerX, radius + 4, centerX + radius, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
