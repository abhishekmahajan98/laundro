import 'package:flutter/material.dart';

class NewFeaturesVote extends StatefulWidget {
  @override
  _NewFeaturesVoteState createState() => _NewFeaturesVoteState();
}

class _NewFeaturesVoteState extends State<NewFeaturesVote> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          title: Text('About us'),
          centerTitle: true,
          backgroundColor: Color(0XFF6bacde),
        ),
        body: Center(
          child: Text('Vote for new features'),
        ),
      ),
    );
  }
}