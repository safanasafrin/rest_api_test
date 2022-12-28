import 'package:flutter/material.dart';
import 'package:rest_api_test/screens/home_screen.dart';

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
        primaryColor: Colors.cyan,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
        )
      ),
      home: HomeScreen(),
    );
  }
}


