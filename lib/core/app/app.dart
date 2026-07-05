import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/theme/app_theme.dart';
import 'package:hungry/features/auth/data/auth_cubit.dart';
import 'package:hungry/features/cart/cubit/cart_cubit.dart';
import 'package:hungry/features/home/data/cubit/home_cubit.dart';
import 'package:hungry/features/order/data/cubit/Order_cubit.dart';
import 'package:hungry/shared/splash.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit()
            ..autoLogin()
            ..getProfileData(),
        ),

        BlocProvider(create: (_) => HomeCubit()..getProducts()),

        BlocProvider(create: (_) => CartCubit()),

        BlocProvider(create: (_) => OrderCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const SplashScreen(),
      ),
    );
  }
}
