import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laundro/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  SharedPreferences prefs;
  FirebaseUser loggedInUser;
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          //header
          UserAccountsDrawerHeader(
            accountName: Text(User.email),
            accountEmail: User.displayName == null ? Text('') : Text(User.displayName),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Color(0xFF73AEF5),
                  )),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF73AEF5),
            ),
          ),
          //body

          InkWell(
            onTap: () => Navigator.pushNamed(context, '/my_account'),
            child: ListTile(
              title: Text('My Account'),
              leading: Icon(
                Icons.person,
                color: Color(0xFF73AEF5),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Previous Orders'),
              leading: Icon(
                Icons.shopping_basket,
                color: Color(0xFF73AEF5),
              ),
            ),
          ),
          InkWell(
            onTap: ()  =>  Navigator.pushNamed(context, '/cart'),
            child: ListTile(
              title: Text('Shopping Cart'),
              leading: Icon(
                Icons.shopping_cart,
                color: Color(0xFF73AEF5),
              ),
            ),
          ),

          Divider(
            color: Color(0xFF73AEF5),
            height: 5,
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/about'),
            child: ListTile(
              title: Text('About us'),
              leading: Icon(
                Icons.help,
                color: Color(0xFF73AEF5),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/contactus'),
            child: ListTile(
              title: Text('Contact us'),
              leading: Icon(
                Icons.contact_phone,
                color: Color(0xFF73AEF5),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              prefs = await SharedPreferences.getInstance();
              prefs.clear();
              _auth.signOut();
              googleSignIn.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/login", (Route<dynamic> route) => false);
            },
            child: ListTile(
              title: Text('Logout'),
              leading: Icon(
                Icons.exit_to_app,
                color: Color(0xFF73AEF5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
