import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBurgerBackground extends StatefulWidget {
  const AnimatedBurgerBackground({super.key});

  @override
  State<AnimatedBurgerBackground> createState() =>
      _AnimatedBurgerBackgroundState();
}

class _AnimatedBurgerBackgroundState
    extends State<AnimatedBurgerBackground>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget item({
    required String image,
    required double left,
    required double size,
    required double delay,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {

        double progress = (controller.value + delay) % 1;

        return Positioned(
          left: left,
          top: MediaQuery.of(context).size.height * (1 - progress),
          child: Transform.rotate(
            angle: progress * pi,
            child: Opacity(
              opacity: .12,
              child: Image.asset(
                image,
                width: size,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [

        item(
          image: "assets/animation/burger.png",
          left: 30,
          size: 100,
          delay: 0,
        ),

        item(
          image: "assets/animation/fries.png",
          left: 250,
          size: 90,
          delay: .25,
        ),

        item(
          image: "assets/animation/cola.png",
          left: 150,
          size: 80,
          delay: .5,
        ),

        item(
          image: "assets/animation/burger.png",
          left: 280,
          size: 70,
          delay: .75,
        ),
      ],
    );
  }
}