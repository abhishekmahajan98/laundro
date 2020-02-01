import 'package:flutter/material.dart';
import 'package:laundro/components/otp_page_stream.dart';
import 'package:laundro/constants.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('OTP Page'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          OtpStream(),
        ],
      ),
    );
  }
}
