import 'package:f_localbrand/config/http_client.dart';
import 'package:f_localbrand/config/router.dart';
import 'package:f_localbrand/features/auth/bloc/auth_bloc.dart';
import 'package:f_localbrand/features/auth/data/auth_api_client.dart';
import 'package:f_localbrand/features/auth/data/auth_local_data_source.dart';
import 'package:f_localbrand/features/auth/data/auth_repository.dart';
import 'package:f_localbrand/features/cart/bloc/cubit/cart_cubit.dart';
import 'package:f_localbrand/features/cart/data/cart_api_client.dart';
import 'package:f_localbrand/features/cart/data/cart_repository.dart';
import 'package:f_localbrand/features/product/bloc/product_cubit.dart';
import 'package:f_localbrand/features/product/data/product_api_client.dart';
import 'package:f_localbrand/features/product/data/product_repository.dart';
import 'package:f_localbrand/features/user/bloc/user_cubit.dart';
import 'package:f_localbrand/features/user/data/user_api_client.dart';
import 'package:f_localbrand/features/user/data/user_local_data_source.dart';
import 'package:f_localbrand/features/user/data/user_repository.dart';
import 'package:f_localbrand/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/themes/custom_themes/button_theme.dart';
import 'config/themes/custom_themes/text_theme.dart';
import 'config/themes/material_theme.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  final sf = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    sharedPreferences: sf,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
              authApiClient: AuthApiClient(dio),
              authLocalDataSource: AuthLocalDataSource(sharedPreferences)),
        ),
        RepositoryProvider(
            create: (context) => UserRepository(
                userApiClient: UserApiClient(dio),
                userLocalDataSource: UserLocalDataSource(sharedPreferences),
                authLocalDataSource: AuthLocalDataSource(sharedPreferences))),
        RepositoryProvider(
            create: (context) =>
                ProductRepository(productApiClient: ProductApiClient(dio))),
        RepositoryProvider(
            create: (context) =>
                CartRepository(cartApiClient: CartApiClient(dio)))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(context.read<AuthRepository>())),
          BlocProvider(
              create: (context) => UserCubit(context.read<UserRepository>())),
          BlocProvider(
              create: (context) => ProductCubit(
                  productRepository: context.read<ProductRepository>())),
          BlocProvider(
              create: (context) =>
                  CartCubit(cartRepository: context.read<CartRepository>()))
        ],
        child: AppContent(),
      ),
    );
  }
}

class AppContent extends StatefulWidget {
  const AppContent({
    super.key,
  });

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  @override
  Widget build(BuildContext context) {
    final MaterialTheme materialTheme = MaterialTheme(
        FTextTheme.light,
        FButtonTheme.lightElevatedButtonTheme,
        FButtonTheme.lightOutlinedButtonTheme);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'F-LocalBrand',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
