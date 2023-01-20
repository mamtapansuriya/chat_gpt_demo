import 'package:demo/screen/homepage_screen.dart';
import 'package:flutter/material.dart';

/// help link
/// https://www.youtube.com/watch?v=94JmNb1IhX0&ab_channel=Codepur
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageScreen(),
    );
  }
}
