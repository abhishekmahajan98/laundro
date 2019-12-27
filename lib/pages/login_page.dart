import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laundro/model/user_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight, screenWidth;
  final _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser loggedInUser;
  final _firestore = Firestore.instance;
  String email, password;
  bool showSpinner = false;
  bool circularSpinner = false;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    instantiateSP();
  }

  void instantiateSP() async {
    prefs = await SharedPreferences.getInstance();
    checkLoggedInStatus();
  }

  void checkLoggedInStatus() {
    if (prefs.containsKey('loggedInUserEmail')) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Hero(
        tag: 'logo',
        child: Container(
          height: 3 * (MediaQuery.of(context).size.height / 20),
          width: 7 * (MediaQuery.of(context).size.width / 10),
          child: Image.asset('images/app_logo/LOGO1.png'),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 1.5 * (MediaQuery.of(context).size.height / 20),
        width: 8 * (MediaQuery.of(context).size.width / 10),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            email = value;
          },
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            labelText: 'Email',
            labelStyle: kLabelStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 1.5 * (MediaQuery.of(context).size.height / 20),
        width: 8 * (MediaQuery.of(context).size.width / 10),
        child: TextField(
          obscureText: true,
          onChanged: (value) {
            password = value;
          },
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            labelText: 'Password',
            labelStyle: kLabelStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildForgetPasswordButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, '/reset_password');
          },
          child: Container(
            padding:
                EdgeInsets.only(right: MediaQuery.of(context).size.width / 10),
            child: Text(
              'Forgot Password ?',
              style: kLabelStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      height: 1.4 * (MediaQuery.of(context).size.height / 20),
      width: 8 * (MediaQuery.of(context).size.width / 10),
      margin: EdgeInsets.only(bottom: 20),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          setState(() {
            circularSpinner = true;
          });
          try {
            final firebaseUser = await _auth.signInWithEmailAndPassword(
                email: email, password: password);
            if (firebaseUser != null) {
              final currentFirebaseUser = await _auth.currentUser();
              loggedInUser = currentFirebaseUser;
              User.email = loggedInUser.email;
              User.uid = loggedInUser.uid;
              prefs.setString('loggedInUserEmail', User.email);
              prefs.setString('loggedInUserUserid', User.uid);
              final userCheck = await _firestore
                  .collection('users')
                  .where('email', isEqualTo: User.email)
                  .limit(1)
                  .getDocuments();
              final userCheckList = userCheck.documents;
              if (userCheckList.length == 1) {
                Navigator.pushReplacementNamed(context, '/login_buffer');
              } else {
                Navigator.pushReplacementNamed(context,"/initial_details");
              }
            }
          } catch (e) {
            print(e);
          }
          setState(() {
            circularSpinner = false;
          });
        },
        //padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: MediaQuery.of(context).size.height / 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(
            '- OR -',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSocialBtn(
          () {},
          AssetImage(
            'images/facebook.jpg',
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 10,
        ),
        _buildSocialBtn(
          () async {
            setState(() {
              showSpinner = true;
            });
            try {
              GoogleSignInAccount account = await _googleSignIn.signIn();

              AuthResult res = await _auth
                  .signInWithCredential(GoogleAuthProvider.getCredential(
                idToken: (await account.authentication).idToken,
                accessToken: (await account.authentication).accessToken,
              ));
              if (res != null) {
                final firebaseUser = await _auth.currentUser();
                loggedInUser = firebaseUser;
                User.email = loggedInUser.email;
                User.uid = loggedInUser.uid;
                prefs.setString('loggedInUserEmail', User.email);
                prefs.setString('loggedInUserUid', User.uid);
                final userCheck = await _firestore
                    .collection('users')
                    .where('email', isEqualTo: User.email)
                    .limit(1)
                    .getDocuments();
                final userCheckList = userCheck.documents;
                if (userCheckList.length == 1) {
                  Navigator.pushReplacementNamed(context, '/login_buffer');
                } else {
                  Navigator.pushReplacementNamed(context, '/initial_details');
                }
              } else {
                print("error logging in with google");
                account.clearAuthCache();
                prefs.clear();
              }
            } catch (e) {
              print(e);
            }
            setState(() {
              showSpinner = false;
            });
          },
          AssetImage(
            'images/google.jpg',
          ),
        ),
      ],
    );
  }

  Widget _buildSignupBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: FlatButton(
        onPressed: () => Navigator.pushNamed(context, '/register'),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an Account? ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height / 40,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height / 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Container(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0XFF6bacde),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildLogo(),
                    _buildEmail(),
                    _buildPassword(),
                    _buildForgetPasswordButton(),
                    _buildLoginButton(),
                    _buildOrRow(),
                    _buildSocialBtnRow(),
                    _buildSignupBtn(),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
