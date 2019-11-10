//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laundro',
      routes: routes(context),
    );
  }
}
