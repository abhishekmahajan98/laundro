import 'package:flutter/material.dart';
import 'package:laundro/pages/about_page.dart';
import 'package:laundro/pages/address_update_page.dart';
import 'package:laundro/pages/login_buffer_page.dart';
import 'package:laundro/pages/contact_us.dart';
import 'package:laundro/pages/logo_splash.dart';
import 'package:laundro/pages/my_account.dart';
import 'package:laundro/pages/order_confirmation_page.dart';
import 'package:laundro/pages/otp_page.dart';
import 'package:laundro/pages/password_reset_page.dart';
import 'package:laundro/pages/shop_change_page.dart';
import 'package:laundro/pages/shop_select_page.dart';
import 'package:laundro/pages/user_initial_details_page.dart';
import 'package:laundro/pages/user_initial_location_page.dart';
import 'package:laundro/pages/your_orders_page.dart';
import './pages/home_page.dart';
import './pages/login_page.dart';
import './pages/registration_page.dart';
import './pages/ironing_menu_page.dart';
import './pages/washing_menu_page.dart';
import './pages/dry_cleaning_menu_page.dart';
import './pages/cart_page.dart';

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
    "/my_account": (context) => MyAccount(),
    "/initial_details": (context) => UserDetailsPage(),
    '/initial_location': (context) => UserLocationPage(),
    '/login_buffer': (context) => BufferPage(),
    '/contactus': (context) => ContactUs(),
    '/previous_orders_page': (context) => YourOrdersPage(),
    '/about_page': (context) => AboutPage(),
    '/order_confirmation_page': (context) => OrderConfirmationPage(),
    '/address_update_page': (context) => AddressUpdatePage(),
    '/otp_page': (context) => OtpPage(),
    '/shop_select_page': (context) => ShopSelectPage(),
    '/shop_change_page': (context) => ShopChangePage(),
  };
}
