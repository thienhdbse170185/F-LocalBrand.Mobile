import 'package:f_localbrand/screens/cart.dart';
import 'package:f_localbrand/screens/favourite.dart';
import 'package:f_localbrand/screens/home.dart';
import 'package:f_localbrand/screens/profile.dart';
import 'package:f_localbrand/screens/shop.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          selectedItemColor: Colors.black,
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Ionicons.home_outline), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Ionicons.search), label: 'Shop'),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.cart_outline), label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.heart_outline), label: 'Favourites'),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.person_outline), label: 'Profile'),
          ]),
    );
  }
}
