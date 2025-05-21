import 'package:flutter/material.dart';
import 'package:flutter_vincipizza/screens/about_screen.dart';
import 'package:flutter_vincipizza/screens/cardapio_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VinciPizza',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const CardapioScreen(),
        "/about": (context) => const AboutScreen()
      },
    );
  }
}
