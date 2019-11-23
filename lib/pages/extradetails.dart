
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



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
  int group=1;

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
      child: TextField(
        obscureText: true,
        onChanged: (value) {

        },

        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Name',
          contentPadding: EdgeInsets.only(top: 4.0,left: 44.0),

          //hintText: 'Enter your Name',

          labelStyle: TextStyle(

            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildPhone()
  {
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
      child: TextField(
        obscureText: true,
        onChanged: (value) {

        },
        keyboardType: TextInputType.phone,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,

          labelText: "Phone Number" ,
          contentPadding: EdgeInsets.only(top: 4.0,left: 44.0),



          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
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
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;

      });
    //return selectedDate;
  }
  Widget _buildGender()
  {
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
          Radio(value: 1,
              groupValue: group,
              onChanged: (T){
                print(T);
                setState(() {
                  group =T;

                });
              }

          ),
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
          Radio(value: 2,
              groupValue: group,
              onChanged: (T){
                print(T);
                setState(() {
                  group =T;

                });
              }

          ),
        ],
      ),
    );
  }
  Widget _buildDOB(){
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
            hintText: selectedDay!=null?"DOB:   "+selectedDay+"/"+selectedMonth+"/"+selectedYear:'Select your DOB',
            contentPadding:EdgeInsets.only(left: 40.0),
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),

          ),
          onChanged: (value){
            setState(() {

            });
          },




        ),
      ),
      trailing: GestureDetector(
        child: Icon(
          Icons.calendar_today,
          color: Colors.white,
        ),
        onTap: () async{
          await _selectDate(context);
          selectedDay=selectedDate.day.toString();
          selectedMonth=selectedDate.month.toString();
          selectedYear=selectedDate.year.toString();
          print(selectedDate.toString());

        },
      ),
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
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
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
                        onPressed: (){},),
                    ],
                  ),



                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
