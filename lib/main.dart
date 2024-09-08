import 'package:codeedextask/screens/loginScreen.dart';
import 'package:codeedextask/screens/otpverificationScreen.dart';
import 'package:codeedextask/screens/registerScreen.dart';
import 'package:codeedextask/screens/start.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: St(),debugShowCheckedModeBanner: false,
    );
  }
}
