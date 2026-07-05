import 'package:flutter/material.dart';
import 'package:hungry/core/theme/custom_text.dart';

class SuccessDailog extends StatelessWidget {
  const SuccessDailog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CustomText('Success'),),
    );
  }
}


