import 'package:flutter/material.dart';
import 'package:frisky_card/view/home_view.dart';

import 'di/repository_module.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  Widget app = MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/my_app',
      routes: {
        '/home': (context) => const HomeView()
        // '/learn_user_report': (context) => const LearnUserReportView()
      });
  // runApp(MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(
  //         create: (_) => HomeViewModel(homeRepo: locator<HomeRepository>())),
  //   ],
  //   child: app,
  // ));
  runApp(app);
}
