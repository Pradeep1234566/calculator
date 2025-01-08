
import 'package:calculator/pages/my_home_page.dart';
import 'package:flutter/material.dart';

/// The main entry point of the application.
///
/// This function initializes the app by calling runApp with an instance of
/// MyApp, which is the root widget of the application.
void main() {
  runApp(const MyApp());
}

/// A stateless widget that represents the root of the application.
///
/// The MyApp widget sets up the `MaterialAp pwith the home page set to
/// `MyHomePag and disables the debug banner.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
