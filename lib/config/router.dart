import 'package:f_localbrand/screens/checkout/checkout.dart';
import 'package:f_localbrand/screens/get_started/get_started.dart';
import 'package:f_localbrand/screens/product/product_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/bloc/auth_bloc.dart';
import '../home.dart';
import '../screens/auth/login/login.dart';
import '../screens/auth/register/register.dart';
import '../screens/profile/profile.dart';

class RouteName {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPw = '/forgot-pw';
  static const String verifyOtp = '/verify-otp';
  static const String resetPw = '/reset-pw';
  static const String profile = '/profile';
  static const String getStarted = '/get-started';
  static const String productDetail = '/product-detail';
  static const String checkout = '/checkout';

  static const publicRoutes = [
    login,
    register,
    getStarted,
    forgotPw,
    verifyOtp,
    resetPw
  ];
}

final router = GoRouter(
  redirect: (context, state) {
    if (RouteName.publicRoutes.contains(state.fullPath)) {
      return null;
    }
    if (context.read<AuthBloc>().state is AuthAuthenticateSuccess) {
      return null;
    }
    return RouteName.getStarted;
  },
  routes: [
    GoRoute(
      path: RouteName.home,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: RouteName.login,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: RouteName.profile,
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: RouteName.register,
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: RouteName.getStarted,
      builder: (context, state) => GetStartedScreen(),
    ),
    GoRoute(
      path: RouteName.productDetail,
      builder: (context, state) {
        final id = state.extra as int;
        return ProductDetailScreen(id: id);
      },
    ),
    GoRoute(
        path: RouteName.checkout, builder: (context, state) => CheckoutScreen())
  ],
);
