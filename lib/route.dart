import 'package:flutter/material.dart';
import 'package:laundro/pages/login_buffer_page.dart';
import 'package:laundro/pages/logo_splash.dart';
import 'package:laundro/pages/my_account.dart';
import 'package:laundro/pages/password_reset_page.dart';
import './pages/home_page.dart';
import './pages/login_page.dart';
import './pages/registration_page.dart';
import './pages/ironing_menu_page.dart';
import './pages/washing_menu_page.dart';
import './pages/dry_cleaning_menu_page.dart';
import './pages/cart_page.dart';
import './pages/order_conform_page.dart';
import './pages/test_page.dart';
import './pages/extradetails.dart';
Map<String, WidgetBuilder> routes(BuildContext context) {
  return <String, WidgetBuilder>{
    "/": (context)=>SplashScreen(),
    '/login':(context)=>LoginScreen(),
    "/register": (context) => RegistrationScreen(),
    "/login": (context) => LoginScreen(),
    "/home": (context) => HomePage(),
    "/iron": (context) => IroningMenuPage(),
    "/wash": (context) => WashingMenuPage(),
    "/dry-clean": (context) => DryCleaningMenuPage(),
    "/cart": (context) => CartPage(),
    "/reset_password": (context) => ResetPasswordScreen(),
    "/order-confirm-page": (context) => OrderConfirmPage(),
    "/my_account":(context)=> MyAccount(),
    '/test_page':(context)=>FirestoreTest(),
    "/extradetails":(context)=>UserDetailsPage(),
    '/login_buffer':(context)=>BufferPage(),
  };
}
