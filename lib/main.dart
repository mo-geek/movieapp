import 'package:flutter/material.dart';
import 'package:movieapp/core/constant/const.dart';
import 'package:movieapp/core/utility/db.dart';
import 'package:movieapp/ui/views/home_page.dart';
import 'app/locator.dart';
import 'core/utility/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  setupLocator();
  Preferences.setString(Constant.authTokenKey, Constant.authToken);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieAppAssessment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
