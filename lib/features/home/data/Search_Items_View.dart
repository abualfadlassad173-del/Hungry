import 'package:flutter/material.dart';
import 'package:hungry/features/home/widget/Categary_view.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(18, 24, 18, 0),
      child: SizedBox(
        height: 60,
        child: CategoryItem(),
      ),
    );
  }
}
