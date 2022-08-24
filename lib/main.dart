import 'package:flutter/material.dart';
import 'package:latihan_soal_app/view/login_page.dart';
import 'package:latihan_soal_app/view/register_page.dart';
import 'package:latihan_soal_app/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const SplashScreen(),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        LoginPage.route: (context) => const LoginPage(),
        RegisterPage.route:(context) => const RegisterPage(),
      },
    );
  }
}
