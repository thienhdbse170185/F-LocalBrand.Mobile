import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:f_localbrand/config/router.dart';
import 'package:f_localbrand/features/auth/bloc/auth_bloc.dart';
import 'package:f_localbrand/features/cart/cubit/cart_cubit.dart';
import 'package:f_localbrand/features/category/cubit/category_cubit.dart';
import 'package:f_localbrand/features/product/bloc/product_cubit.dart';
import 'package:f_localbrand/features/user/bloc/user_cubit.dart';
import 'package:f_localbrand/screens/cart/cart.dart';
import 'package:f_localbrand/screens/favourite/favourite.dart';
import 'package:f_localbrand/screens/home/home.dart';
import 'package:f_localbrand/screens/profile/profile.dart';
import 'package:f_localbrand/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserInfo();
    context.read<ProductCubit>().fetchProductsBestseller();
    context.read<ProductCubit>().fetchProductsNewest();
    context.read<CategoryCubit>().fetchCategories();
    context.read<CategoryCubit>().fetchCategoriesProducts();
    context.read<CartCubit>().fetchCart();
    context.read<ProductCubit>().fetchCustomerProductRecommendations(7);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    List<Widget> screens = [
      const HomeItemScreen(),
      const SearchScreen(),
      const CartScreen(),
      FavouriteScreen(textTheme: textTheme, colorScheme: colorScheme),
      const ProfileScreen()
    ];

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLogoutSuccess) {
          context.go(RouteName.getStarted);
        }
      },
      child: Scaffold(
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
                DotNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.cartShopping)),
                DotNavigationBarItem(icon: FaIcon(FontAwesomeIcons.solidHeart)),
                DotNavigationBarItem(icon: FaIcon(FontAwesomeIcons.solidUser)),
              ],
              selectedItemColor: colorScheme.primary,
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
      ),
    );
  }
}
