import 'package:flutter/material.dart';

import './pages/home_page.dart';
import './pages/login_page.dart';
import './pages/welcome.dart';
import './pages/registration_page.dart';
import './pages/ironing_menu_page.dart';
import './pages/washing_menu_page.dart';
import './pages/dry_cleaning_menu_page.dart';
import './pages/cart_page.dart';
import './pages/order_conform_page.dart';

Map<String, WidgetBuilder> routes(BuildContext context) {
  return <String, WidgetBuilder>{
    "/": (context) => WelcomeScreen(),
    "/login": (context) => LoginScreen(),
    "/register": (context) => RegistrationScreen(),
    "/home": (context) => HomePage(),
    "/iron": (context) => IroningMenuPage(),
    "/wash": (context) => WashingMenuPage(),
    "/dry-clean": (context) => DryCleaningMenuPage(),
    "/cart": (context) => CartPage(),
    "/order-confirm-page": (context) => OrderConfirmPage()
  };
}
