//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:laundro/pages/home_page.dart';
import 'package:laundro/pages/login_page.dart';
import 'package:laundro/pages/welcome.dart';
import 'package:laundro/pages/registration_page.dart';
import './pages/ironing_menu_page.dart';
import './pages/washing_menu_page.dart';
import './pages/dry_cleaning_menu_page.dart';
import './pages/cart_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laundro',
      initialRoute: WelcomeScreen.id,
      routes: {
        "/": (context) => WelcomeScreen(),
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegistrationScreen(),
        "/": (context) => HomePage(),
        "/iron": (context) => IroningMenuPage(),
        "/wash": (context) => WashingMenuPage(),
        "/dry-clean": (context) => DryCleaningMenuPage(),
        "/cart": (context) => CartPage()
      },
    );
  }
}
