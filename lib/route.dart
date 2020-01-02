import 'package:flutter/material.dart';
import 'package:laundro/pages/about_page.dart';
import 'package:laundro/pages/donation_page.dart';

import 'package:laundro/pages/login_buffer_page.dart';
import 'package:laundro/pages/contact_us.dart';
import 'package:laundro/pages/logo_splash.dart';
import 'package:laundro/pages/my_account.dart';
import 'package:laundro/pages/order_confirm_buffer.dart';
import 'package:laundro/pages/password_reset_page.dart';
import 'package:laundro/pages/previous_orders_page.dart';
import 'package:laundro/pages/user_initial_address_page.dart';
import 'package:laundro/pages/user_initial_details_page.dart';
import 'package:laundro/pages/vote_for_feature_page.dart';
import './pages/home_page.dart';
import './pages/login_page.dart';
import './pages/registration_page.dart';
import './pages/ironing_menu_page.dart';
import './pages/washing_menu_page.dart';
import './pages/dry_cleaning_menu_page.dart';
import './pages/cart_page.dart';
import './pages/order_conform_page.dart';


Map<String, WidgetBuilder> routes(BuildContext context) {
  return <String, WidgetBuilder>{
    "/": (context) => SplashScreen(),
    '/login': (context) => LoginScreen(),
    "/register": (context) => RegistrationScreen(),
    "/home": (context) => HomePage(),
    "/iron": (context) => IroningMenuPage(),
    "/wash": (context) => WashingMenuPage(),
    "/dry-clean": (context) => DryCleaningMenuPage(),
    "/cart": (context) => CartPage(),
    "/reset_password": (context) => ResetPasswordScreen(),
    "/order-confirm-page": (context) => OrderConfirmPage(),
    "/my_account": (context) => MyAccount(),
    "/initial_details": (context) => UserDetailsPage(),
    '/login_buffer': (context) => BufferPage(),
    '/contactus': (context) => ContactUs(),
    '/initial_address': (context) => UserAddressPage(),
    '/donate_page':(context)=>DonatePage(),
    '/previous_orders_page':(context)=>YourOrdersPage(),
    '/about_page':(context)=>AboutPage(),
    '/new_features':(context)=>NewFeaturesVote(),
    '/order_confirm_buffer':(context)=>OrderConfirmBuffer(),
      };
}
