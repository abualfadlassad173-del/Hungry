import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';

class AppbarBack extends StatefulWidget
    implements PreferredSizeWidget {
  const AppbarBack({
    super.key,
    required this.background,
    required this.onTap,
  });

  final Color background;
  final VoidCallback onTap;

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);

  @override
  State<AppbarBack> createState() => _AppbarBackState();
}

class _AppbarBackState extends State<AppbarBack> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: widget.background,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Appcolors.black,
        ),
        onPressed: widget.onTap,
      ),
    );
  }
}