//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './route.dart';

Future<void> main() async  => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    precacheImage(AssetImage("images/app_logo/LOGO1.png"), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laundro',
      routes: routes(context),
    );
  }
}
