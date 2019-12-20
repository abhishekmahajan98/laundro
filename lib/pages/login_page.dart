import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laundro/model/user_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
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
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
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
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, '/reset_password');
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.only(top: 2, bottom: 20),
      width: double.infinity,
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
                Navigator.pushReplacementNamed(context, '/extradetails');
              }
            }
          } catch (e) {
            print(e);
          }
          setState(() {
            circularSpinner = false;
          });
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: circularSpinner
            ? CircularProgressIndicator()
            : Text(
                'LOGIN',
                style: TextStyle(
                  color: Color(0xFF527DAA),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        /*SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),*/
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Facebook'),
            AssetImage(
              'images/facebook.jpg',
            ),
          ),
          SizedBox(
            width: 40,
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
                    Navigator.pushReplacementNamed(context, '/extradetails');
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
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/register'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                //fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                //fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
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
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            /*Text(
                              'Laundro',
                              style: TextStyle(
                                color: Colors.white,
                                //fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),*/
                            Hero(
                              tag: 'logo',
                              child: Icon(
                                Icons.local_laundry_service,
                                size: 150,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            _buildEmailTF(),
                            SizedBox(
                              height: 30.0,
                            ),
                            _buildPasswordTF(),
                            _buildForgotPasswordBtn(),
                            _buildLoginBtn(),
                            _buildSignInWithText(),
                            _buildSocialBtnRow(),
                            _buildSignupBtn(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
