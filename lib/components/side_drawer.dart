import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideDrawer extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          //header
          UserAccountsDrawerHeader(
            accountName: Text('Abhishek Mahajan'),
            accountEmail: Text('abhishekmah98@gmail.com'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          //body
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/'),
            child: ListTile(
              title: Text('Home'),
              leading: Icon(
                Icons.home,
                color: Colors.pinkAccent,
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/myaccount'),
            child: ListTile(
              title: Text('My Account'),
              leading: Icon(
                Icons.person,
                color: Colors.pinkAccent,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Previous Orders'),
              leading: Icon(
                Icons.shopping_basket,
                color: Colors.pinkAccent,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Shopping Cart'),
              leading: Icon(
                Icons.shopping_cart,
                color: Colors.pinkAccent,
              ),
            ),
          ),

          Divider(
            color: Colors.teal,
            height: 5,
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/about'),
            child: ListTile(
              title: Text('About us'),
              leading: Icon(
                Icons.help,
                color: Colors.pinkAccent,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Contact us'),
              leading: Icon(
                Icons.contact_phone,
                color: Colors.pinkAccent,
              ),
            ),
          ),
          InkWell(
            onTap: () async{
              prefs = await SharedPreferences.getInstance();
              prefs.remove('loggedInUserEmail');
              _auth.signOut();
              googleSignIn.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil("/",(Route<dynamic> route) => false);
            },
            child: ListTile(
              title: Text('Logout'),
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.pinkAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
