import 'package:flutter/material.dart';
import 'package:frisky_card/view/home_view.dart';

import 'di/repository_module.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  Widget app = MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeView()
      });
  runApp(app);
}
