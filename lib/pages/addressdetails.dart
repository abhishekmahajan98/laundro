import 'package:flutter/material.dart';
import 'package:laundro/model/user_model.dart';

class AddressDetails extends StatefulWidget {
  @override
  _AddressDetailsState createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  bool editPrimaryAddress = false;

  String displayName = 'null', email = 'null';
  String updatedNumber = User.phone;
  String updatedLine1='';
  String updatedLine2='';
  String updatedCity;
  String updatedState;
  String pincode=User.pincode;
  String primaryAddress=User.address;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: <Widget>[
            ListTile(

              leading: Icon(

                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                'Primary Address',
                style: TextStyle(
                    color: Colors.white, fontSize: 18),
              ),
              trailing: GestureDetector(
                onTap: (){
                  setState(() {
                    editPrimaryAddress=!editPrimaryAddress;
                  });
                },
                child: Icon(
                  editPrimaryAddress == false
                      ? Icons.edit
                      : Icons.check,
                  color: Colors.black,
                ),
              ),

            ),

            ListTile(
              leading: Text("Line 1      "),
              title: TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                enabled: editPrimaryAddress,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    updatedLine1 = value;
                  });
                },

              ),
            ),
            ListTile(
              leading: Text("Line 2      "),
              title: TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                enabled: editPrimaryAddress,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    updatedLine2 = value;
                  });
                },

              ),
            ),
            ListTile(
              leading: Text("City         "),
              title: TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                enabled: editPrimaryAddress,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    updatedCity = value;
                  });
                },

              ),
            ),
            ListTile(
              leading: Text("State       "),
              title: TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                enabled: editPrimaryAddress,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    updatedState = value;
                  });
                },

              ),
            ),
            ListTile(
              leading: Text("Pincode  "),
              title: TextFormField(
                initialValue: pincode,

                style: TextStyle(
                  color: pincode.length == 6
                      ? Colors.white
                      : Colors.red,
                ),
                enabled: editPrimaryAddress,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  setState(() {
                    pincode = value;
                  });
                },

              ),
            ),

          ],
        ),
      ),

    );
  }
}












