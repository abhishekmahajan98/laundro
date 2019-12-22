import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/user_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _firestore = Firestore.instance;
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Contact us'),
        centerTitle: true,
      ),
      body: Container(
        
        decoration: BoxDecoration(
          color: Color(0xfff2f3f7),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              'Queries',
              style: kTitleTextStyle,
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "What's Bothering you?",
                  hintStyle: kBlackLabelTextStyle,
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.all(new Radius.circular(10.0))
                    ),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                maxLines: 8,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  setState(() {
                    message = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              height: 50,
              child: RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Send",
                  style: kCategoryTextStyle,
                ),
                onPressed: () {
                  if(message!=""){
                    print(message);
                    try{
                      _firestore.collection('queries').add({
                        'uid':User.uid,
                        'name':User.displayName,
                        'email':User.email,
                        'message': message,
                      });
                    }
                    catch(e){
                      print(e);
                    }
                  
                  Alert(
                    context: context,
                    title: 'Query Registered!!',
                    desc:
                        'Thank you for using our application and giving us valuable feedback!\n We will work on the issue occured and get back to you as soon as possible.',
                    buttons: [
                      DialogButton(
                        child: Text('Okay'),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ]).show();
                  }
                  else{
                    Alert(
                    context: context,
                    title: 'Empty Query',
                    desc:'Please enter a query then press send!',
                    buttons: [
                      DialogButton(
                        child: Text('Okay'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ]).show();
                  }
                },
              ),
            ),

            Divider(
              color: Colors.black,
              height: 30,
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.blue,
                size: 50,
              ),
              title: Text(
                "8800418884",
                style: kCategoryTextStyle,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.email,
                color: Colors.blue,
                size: 50,
              ),
              title: Text(
                "laundro@gmail.com",
                style: kCategoryTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
