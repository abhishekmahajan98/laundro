import 'package:flutter/material.dart';
class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About us'),
        centerTitle: true,
        backgroundColor: Colors.blue,

      ),
      body:
      Container(
        height: 700.0,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          '''
Laundro is an online service for providing end-to end household 
services.Laundro will act as a platform generating value for the customers and shop alike.Shop will display the services offered and the charges for the same.
The customers can use the services through the platform at resonable prices and more importantly at their convinience.'''
          ,
          style: TextStyle(color: Colors.white,
            fontSize: 20.0,),


        ),
      ),
    );
  }
}
