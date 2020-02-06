import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  SharedPreferences prefs;
  FirebaseUser loggedInUser;
  @override
  void initState() {
    intatiatePrefs();
    super.initState();
  }

  void intatiatePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f3f7),
      appBar: AppBar(
        title: Text('My Account'),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: MediaQuery.of(context).size.width / 9.5,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/avatar.png'),
                      radius: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              child: Text(
                                User.displayName,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              User.email,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  AccountPageListItem(
                    title: 'Your Orders',
                    iconData: Icons.shopping_basket,
                    onPressedFunc: () {
                      Navigator.pushNamed(context, '/previous_orders_page');
                    },
                  ),
                  AccountPageListItem(
                    title: 'Information Update',
                    iconData: Icons.person,
                    onPressedFunc: () {
                      Navigator.pushNamed(context, '/address_update_page');
                    },
                  ),
                  AccountPageListItem(
                    title: 'Change Shop',
                    iconData: Icons.local_laundry_service,
                    onPressedFunc: () {
                      Navigator.pushNamed(context, '/shop_change_page');
                    },
                  ),
                  AccountPageListItem(
                    title: 'About Us',
                    iconData: Icons.info,
                    onPressedFunc: () {
                      Navigator.pushNamed(context, '/about_page');
                    },
                  ),
                  AccountPageListItem(
                    title: 'Logout',
                    iconData: Icons.exit_to_app,
                    onPressedFunc: () {
                      prefs.clear();
                      _auth.signOut();
                      googleSignIn.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/login", (Route<dynamic> route) => false);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                  ),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          AccountPageListTile(
                            text: 'Contact Us:',
                          ),
                          AccountPageListTile(
                              text: 'laundro@gmail.com', icondata: Icons.email),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    child: MaterialButton(
                      height: MediaQuery.of(context).size.height / 9.0,
                      onPressed: () {
                        Navigator.pushNamed(context, '/contactus');
                      },
                      child: AccountPageListTile(
                          text: 'Raise Query', icondata: Icons.question_answer),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountPageListTile extends StatelessWidget {
  final String text;
  final IconData icondata;
  AccountPageListTile({Key key, this.text, this.icondata});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
      ),
      trailing: Icon(
        icondata,
        size: 35,
      ),
    );
  }
}

class AccountPageListItem extends StatelessWidget {
  AccountPageListItem(
      {@required this.onPressedFunc,
      @required this.iconData,
      @required this.title});
  final Function onPressedFunc;
  final IconData iconData;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: MaterialButton(
        height: MediaQuery.of(context).size.height / 9.0,
        onPressed: onPressedFunc,
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          trailing: Icon(
            iconData,
            size: 35,
          ),
        ),
      ),
    );
  }
}
