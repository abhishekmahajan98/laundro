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
  String phone='';

  @override
  void initState() {
    super.initState();
    instantiateSP();
  }

  void instantiateSP() async {
    prefs = await SharedPreferences.getInstance();
  }

  Widget _buildName() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Color(0xFF6CA8F1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 60.0,
      child: TextFormField(
        initialValue: User.displayName,
        onChanged: (value) {
          setState(() {
            User.displayName = value;
          });
        },
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Name',
          contentPadding: EdgeInsets.only(top: 4.0, left: 44.0),
          labelStyle: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildPhone() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Color(0xFF6CA8F1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 60.0,
      child: TextFormField(
        initialValue: User.phone,
        onChanged: (value) {
          setState(() {
            phone = value;
          });
        },
        keyboardType: TextInputType.phone,
        style: TextStyle(
          color: phone.length == 10 ? Colors.white : Colors.red,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: "Phone Number",
          contentPadding: EdgeInsets.only(top: 4.0, left: 44.0),
          labelStyle: kLabelStyle,
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != User.dob)
      setState(() {
        User.dob = picked;
      });
  }

  Widget _buildGender() {
    return Container(
      height: 60.0,
      //alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFF6CA8F1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.mars,
            color: Colors.white,
          ),
          Text(
            'Male:',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
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
            color: Colors.white,
          ),
          Text(
            'Female:',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
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

  Widget _buildDOB() {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Container(
        alignment: Alignment.centerLeft,
        height: 60.0,
        decoration: BoxDecoration(
          color: Color(0xFF6CA8F1),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: selectedDay != null
                ? "DOB:   " +
                    selectedDay +
                    "/" +
                    selectedMonth +
                    "/" +
                    selectedYear
                : 'Select your DOB',
            contentPadding: EdgeInsets.only(left: 40.0),
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
      trailing: GestureDetector(
        child: Icon(
          Icons.calendar_today,
          color: Colors.white,
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

  Widget _nextButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Next',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
          ),
          onPressed: () {
            if(phone!=null){
              User.phone=phone;
            }
            if (User.displayName != '' &&
                User.phone.length == 10 &&
                User.dob != null &&
                isNumeric(User.phone)) {
              Navigator.pushReplacementNamed(context, '/initial_address');
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
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
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: Container(
              margin: EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Extra Details',
                    style: TextStyle(
                      color: Colors.white,
                      //fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  _buildName(),
                  SizedBox(height: 30.0),
                  _buildPhone(),
                  SizedBox(
                    height: 30.0,
                  ),
                  _buildDOB(),
                  SizedBox(height: 30.0),
                  _buildGender(),
                  SizedBox(
                    height: 30,
                  ),
                  _nextButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
