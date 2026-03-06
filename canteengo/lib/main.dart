import 'package:canteengo/screens/chechout_screen.dart';
import 'package:canteengo/pages/login_page.dart';
import 'package:canteengo/screens/order_status.dart';
import 'package:canteengo/pages/student_profile.dart';
import 'package:canteengo/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const CanteenGoProfileApp(),
    );
  }
}
