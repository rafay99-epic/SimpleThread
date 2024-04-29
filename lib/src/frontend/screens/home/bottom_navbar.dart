// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:simplethread/src/frontend/screens/chat/groups.dart';
import 'package:simplethread/src/frontend/screens/chat/home.dart';
import 'package:simplethread/src/frontend/screens/profile/profile.dart';
import 'package:simplethread/src/frontend/screens/setting/setting_page.dart';

class Navbar extends StatefulWidget {
  // const Navbar({super.key});
  const Navbar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _navgationBottomBar(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  final List<Widget> _pages = [
    HomePage(),
    // const Groups(),
    Profile(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: GNav(
          backgroundColor: Theme.of(context).colorScheme.background,
          activeColor: Theme.of(context).colorScheme.primary,
          color: Theme.of(context).colorScheme.primary,
          gap: 8,
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            // GButton(
            //   icon: Icons.group,
            //   text: "Groups",
            // ),
            GButton(
              icon: Icons.person,
              text: "Profile",
            ),
            GButton(
              icon: Icons.settings,
              text: "Settings",
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (int index) {
            _navgationBottomBar(index);
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
    );
  }
}
