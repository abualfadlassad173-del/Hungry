import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/root.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _logoOpacity;
  late Animation<double> _logoScale;
  late Animation<Offset> _imageSlide;

  //Check Login
  AuthRepo authRepo = AuthRepo();
  Future<void> checkLogin() async {
   try {
    final user = await authRepo.autoLogin();
      if(!mounted)return;

      if (authRepo.isGuest) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Root()),
      );
    }  else if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Root()),
      );
    }else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    }
   } catch (e) {
     print(e);
   }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _logoOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _logoScale = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _imageSlide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;

      await checkLogin();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 200),
              Center(
                child: FadeTransition(
                  opacity: _logoOpacity,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: SvgPicture.asset('assets/logo/logo.svg', height: 50),
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _imageSlide,
              child: Image.asset('assets/splash/splash.png', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
