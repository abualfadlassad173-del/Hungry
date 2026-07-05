import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungry/core/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}
