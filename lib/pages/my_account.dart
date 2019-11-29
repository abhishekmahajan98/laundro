import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundro/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';


class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  SharedPreferences prefs;
  bool editPhoneNumber=false;
  bool editPrimaryAddress=false;
  bool editSecondaryAddress=false;
  String displayName='null',email='null';
  String updatedNumber=User.phone;
  final _firestore=Firestore.instance;
  
  @override
  void initState() {
    super.initState();
    instantiateSP();
  }
  void instantiateSP() async{
    prefs = await SharedPreferences.getInstance();
    print(User.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Account"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              highlightColor: Colors.blue,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white,fontSize: 20),
              ),
              onPressed: (){
                if(updatedNumber.length==10 && updatedNumber!=User.phone){
                  User.phone=updatedNumber;
                  prefs.remove('loggedInUserPhoneNumber');
                  prefs.setString('loggedInUserPhoneNumber', User.phone);
                  _firestore.collection('users').document(User.uid).updateData({
                    'phoneNumber':User.phone,
                    });
                  Navigator.pop(context);
                }
              },
            )
          ],
          backgroundColor: Color(0xFF73AEF5),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF73AEF5),
                          Color(0xFF61A4F1),
                          Color(0xFF478DE0),
                          Color(0xFF398AE5),
                          ],
                        stops: [0.3, 0.4, 0.7, 0.9],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 60,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child:ListView(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            displayName==null?'':displayName,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: TextFormField(
                          enabled: editPhoneNumber,
                          keyboardType: TextInputType.phone,
                          initialValue: User.phone,
                          style: TextStyle(
                            fontSize: 20,
                            color: updatedNumber.length==10?Colors.white:Colors.red,
                          ),
                          onChanged: (value){
                            setState(() {
                              updatedNumber=value;
                            });
                            
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            prefixText: '+91-',
                            hintText: 'Enter your Email',
                            hintStyle: kHintTextStyle,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: (){
                            setState(() {
                              editPhoneNumber=!editPhoneNumber;
                            });
                          },
                          child: Icon(
                          editPhoneNumber==false?Icons.edit:Icons.check,
                          color: Colors.black,
                          ),
                        ),
                      ),
                      
                      ExpansionTile(
                        title: Text('Addresses',style: TextStyle(color: Colors.white,fontSize: 22),),
                        children: <Widget>[
                          ExpansionTile(
                            title: Text('Primary Address',style: TextStyle(color: Colors.white,fontSize: 18),),
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        editPrimaryAddress=!editPrimaryAddress;
                                      });
                                    },
                                    child: Icon(
                                      editPrimaryAddress==false?Icons.edit:Icons.check,
                                    ),
                                  ),
                                  SizedBox(width: 20,)
                                ],
                              ),
                              ListTile(
                                title: TextFormField(
                                  enabled: editPrimaryAddress,
                                  keyboardType: TextInputType.text,
                                  initialValue: 'F-63',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  
                                  decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixText:'Line 1:',
                                  ),
                                ),
                              ),
                              ListTile(
                                title: TextFormField(
                                  enabled: editPrimaryAddress,
                                  keyboardType: TextInputType.text,
                                  initialValue: 'Mansarover Garden',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  
                                  decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixText:'Line 2:',
                                  ),
                                ),
                              ),
                              ListTile(
                                title: TextFormField(
                                  enabled: editPrimaryAddress,
                                  keyboardType: TextInputType.text,
                                  initialValue: 'Mansarover Garden',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),   
                                  decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixText:'Line 3:',
                                  ),
                                ),
                              ),
                              ListTile(
                                title: TextFormField(
                                  enabled: editPrimaryAddress,
                                  keyboardType: TextInputType.number,
                                  initialValue: '11015',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  
                                  decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixText:'Pin Code',
                                  ),
                                ),
                              )
                            ],
                          ),
                          ExpansionTile(

                            title: Text('Secondary Address',style: TextStyle(color: Colors.white,fontSize: 18),),
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        editSecondaryAddress=!editSecondaryAddress;
                                      });
                                    },
                                    child: Icon(
                                      editSecondaryAddress==false?Icons.edit:Icons.check,
                                    ),
                                  ),
                                  SizedBox(width: 20,)
                                ],
                              ),
                              ListTile(
                                title: TextFormField(
                                  
                                  enabled: editSecondaryAddress,
                                  keyboardType: TextInputType.text,
                                  initialValue: 'F-63',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  
                                  decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixText:'Line 1:',
                                  ),
                                ),
                              ),
                              ListTile(
                                title: TextFormField(
                                  enabled: editSecondaryAddress,
                                  keyboardType: TextInputType.text,
                                  initialValue: 'Mansarover Garden',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  
                                  decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixText:'Line 2:',
                                  ),
                                ),
                              ),
                              ListTile(
                                title: TextFormField(
                                  enabled: editSecondaryAddress,
                                  keyboardType: TextInputType.text,
                                  initialValue: 'Mansarover Garden',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  
                                  decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixText:'Line 3:',
                                  ),
                                ),
                              ),
                              ListTile(
                                title: TextFormField(
                                  enabled: editSecondaryAddress,
                                  keyboardType: TextInputType.number,
                                  initialValue: '110015',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  
                                  decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixText:'Pin Code:',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
