import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/features/auth/view/Profile_view.dart';
import 'package:hungry/features/cart/view/Cart_view.dart';
import 'package:hungry/features/home/view/home.dart';
import 'package:hungry/features/order/view/order_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController _controller;
  late List<Widget> screens;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    screens = [Home(), CartView(), OrderView(), ProfileView()];
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBody: true,
        body: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() => currentIndex = index);
          },
          children: screens,
        ),

        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Appcolors.background.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: GNav(
                    selectedIndex: currentIndex,
                    onTabChange: (index) {
                      _controller.jumpToPage(index);
                    },
                    gap: 8,
                    color: Colors.white70,
                    activeColor: Colors.white,
                    tabBackgroundColor: Colors.white.withValues(alpha: 0.15),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    tabs: const [
                      GButton(icon: Icons.home_rounded, text: "Home"),
                      GButton(icon: Icons.shopping_cart, text: "Cart"),
                      GButton(icon: Icons.receipt_long_rounded, text: "Orders"),
                      GButton(icon: Icons.person_rounded, text: "Profile"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
