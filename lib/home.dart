import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:f_localbrand/screens/cart/cart.dart';
import 'package:f_localbrand/screens/favourite.dart';
import 'package:f_localbrand/screens/home/home.dart';
import 'package:f_localbrand/screens/profile/profile.dart';
import 'package:f_localbrand/screens/shop.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> screens = [
    const HomeItemScreen(),
    const ShopScreen(),
    const CartScreen(),
    const FavouriteScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      extendBody: true,
      bottomNavigationBar: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: DotNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              DotNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house)),
              DotNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.magnifyingGlass)),
              DotNavigationBarItem(icon: FaIcon(FontAwesomeIcons.cartShopping)),
              DotNavigationBarItem(icon: FaIcon(FontAwesomeIcons.solidHeart)),
              DotNavigationBarItem(icon: FaIcon(FontAwesomeIcons.solidUser)),
            ],
            selectedItemColor: colorScheme.onSurface,
            unselectedItemColor: Colors.black.withOpacity(0.4),
            dotIndicatorColor: Colors.white,
            enableFloatingNavBar: true,
            enablePaddingAnimation: false,
            marginR: const EdgeInsets.symmetric(horizontal: 8),
            paddingR: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            borderRadius: 100,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 4),
                blurRadius: 12,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.14),
                offset: Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                offset: Offset(0, 1),
                blurRadius: 5,
                spreadRadius: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
