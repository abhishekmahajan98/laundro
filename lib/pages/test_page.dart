import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreTest extends StatefulWidget {
  @override
  _FirestoreTestState createState() => _FirestoreTestState();
}

class _FirestoreTestState extends State<FirestoreTest> {
  final _auth=FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  final _firestore=Firestore.instance;
  String messageText;
  void messagesStream()async{
    await for(var snapshot in _firestore.collection('users').snapshots()){
      for(var message in snapshot.documents){
        print(message.data);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
              stream:_firestore.collection('users').snapshots(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  final messages=snapshot.data.documents;
                  List<Text> messageWidgets=[];
                  for(var message in messages){
                    final messageText=message.data['email'];
                    final messageSender=message.data['name'];
                    final messageWidget=Text('$messageSender : $messageText',style: TextStyle(fontSize: 35.0),);
                    messageWidgets.add(messageWidget);
                  }
                  return Expanded(
                    child: ListView(
                    children: messageWidgets,
                ),
                  );
                }
                else{
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                
                
              },
            ),
            ],
          ),
        ),
      );
  }
}