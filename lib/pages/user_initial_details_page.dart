import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laundro/components/check_numeric.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/user_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsPage extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  DateTime selectedDate = DateTime.now();
  //DateTime selectedDt=DateTime.now();
  String selectedDay;
  String selectedMonth;
  String selectedYear;
  String userGender = 'male';
  SharedPreferences prefs;
  String phone = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != User.dob)
      setState(() {
        User.dob = picked;
      });
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Text(
            'GIMME',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameTF() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            User.displayName = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Name',
        ),
      ),
    );
  }

  Widget _buildPhone() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        //initialValue: User.phone,
        onChanged: (value) {
          setState(() {
            phone = value;
          });
        },
        keyboardType: TextInputType.phone,
        style: TextStyle(
          color: phone.length == 10 ? Colors.black : Colors.red,
        ),
        decoration: InputDecoration(
          labelText: "Phone Number",
        ),
      ),
    );
  }

  Widget _buildDOB() {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            hintText: selectedDay != null
                ? "DOB:   " +
                    selectedDay +
                    "/" +
                    selectedMonth +
                    "/" +
                    selectedYear
                : 'Select your DOB',
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
      trailing: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.calendar_today,
            color: Colors.black,
          ),
        ),
        onTap: () async {
          await _selectDate(context);
          selectedDay = User.dob.day.toString();
          selectedMonth = User.dob.month.toString();
          selectedYear = User.dob.year.toString();
          print(User.dob.toString());
        },
      ),
    );
  }

  Widget _buildGender() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Text(
            'Gender: ',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 45,
            ),
          ),
          Icon(
            FontAwesomeIcons.mars,
            color: Colors.black,
            size: MediaQuery.of(context).size.height / 45,
          ),
          Text(
            'Male:',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 48,
            ),
          ),
          Radio(
              value: 'male',
              groupValue: userGender,
              onChanged: (gender) {
                print(gender);
                setState(() {
                  userGender = gender;
                  User.gender = gender;
                });
              }),
          Icon(
            FontAwesomeIcons.venus,
            color: Colors.black,
            size: MediaQuery.of(context).size.height / 45,
          ),
          Text(
            'Female:',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 48,
            ),
          ),
          Radio(
              value: 'female',
              groupValue: userGender,
              onChanged: (gender) {
                print(gender);
                setState(() {
                  userGender = gender;
                  User.gender = gender;
                });
              }),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20, top: 10),
          child: RaisedButton(
            elevation: 5.0,
            onPressed: () {
              if (phone != null) {
                User.phone = phone;
              }
              if (User.displayName != '' &&
                  User.phone.length == 10 &&
                  User.dob != null &&
                  isNumeric(User.phone)) {
                Navigator.pushReplacementNamed(context, '/initial_location');
              } else {
                Alert(
                    context: context,
                    title: 'Please fill the form ',
                    desc:
                        'Please fill the name,10 digit phone number and the Date of birth',
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: mainColor,
            child: Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: new BorderRadius.all(Radius.circular(20)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'User Details',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                      ),
                    ),
                  ],
                ),
                _buildNameTF(),
                _buildPhone(),
                _buildDOB(),
                _buildGender(),
                _buildSubmitButton(),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xfff2f3f7),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(70),
                  bottomRight: const Radius.circular(70),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLogo(),
              _buildContainer(),
            ],
          )
        ],
      ),
    );
  }
}
