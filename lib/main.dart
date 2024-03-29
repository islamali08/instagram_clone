import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'layout/home_sceen.dart';
import 'module/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:homescreen() ,
    );
  }
}
