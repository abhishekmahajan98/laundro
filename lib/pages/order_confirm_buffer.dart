import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';



class OrderConfirmBuffer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF6bacde),
      body: Center(
        child: AwesomeLoader(
          loaderType: AwesomeLoader.AwesomeLoader3,
          color: Colors.white,
        ),
      ),
    );
  }
}