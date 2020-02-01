import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laundro/model/user_model.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

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
  SharedPreferences prefs;
  final _loginScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    instantiateSP();
    checkForPermissions();
  }

  void instantiateSP() async {
    prefs = await SharedPreferences.getInstance();
    checkLoggedInStatus();
  }

  void checkForPermissions() async {
    PermissionStatus permission =
        await LocationPermissions().checkPermissionStatus();
    ServiceStatus serviceStatus =
        await LocationPermissions().checkServiceStatus();
    PermissionStatus p;
    if (permission == PermissionStatus.unknown) {
      p = await LocationPermissions().requestPermissions();
    }
    if (serviceStatus == ServiceStatus.disabled) {
      Alert(
          context: context,
          title: 'Please enable your location services',
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Okay'),
            ),
          ]).show();
    }
    if (permission == PermissionStatus.denied) {
      Alert(
          context: context,
          title:
              'Please give us permission in application\'s settings to get your location to deliver your clothes right to you.',
          buttons: [
            DialogButton(
              onPressed: () async {
                bool isOpened = await LocationPermissions().openAppSettings();
              },
              child: Text('Open settings'),
            ),
          ]).show();
    }
  }

  void checkLoggedInStatus() {
    if (prefs.containsKey('loggedInUserEmail')) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Widget _buildSignupBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: FlatButton(
        onPressed: () => Navigator.pushNamed(context, '/register'),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an Account? ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.height / 40,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                  color: mainColor,
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

  Widget _buildEmailTF() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: mainColor,
          ),
          labelText: 'E-mail',
        ),
      ),
    );
  }

  Widget _buildPasswordTF() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Password',
        ),
      ),
    );
  }

  Widget _buildForgetPasswordButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, '/reset_password');
          },
          child: Text(
            'Forgot Password ?',
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            onPressed: () async {
              setState(() {
                showSpinner = true;
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
                    Navigator.pushReplacementNamed(context, "/initial_details");
                  }
                }
              } on PlatformException catch (e) {
                setState(() {
                  showSpinner = false;
                });
                print(e.message.toString());
                _loginScaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(e.message.toString()),
                ));
              }
              setState(() {
                showSpinner = false;
              });
            },
            //padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: mainColor,
            child: Text(
              'Login',
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

  Widget _buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(
            '- OR -',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, IconData iconData) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: mainColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
            } on PlatformException catch (e) {
              print(e);
            }
            setState(() {
              showSpinner = false;
            });
          },
          FontAwesomeIcons.google,
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
                      'Login',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                      ),
                    ),
                  ],
                ),
                _buildEmailTF(),
                _buildPasswordTF(),
                _buildForgetPasswordButton(),
                _buildLoginButton(),
                _buildOrRow(),
                _buildSocialBtnRow(),
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
      key: _loginScaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xfff2f3f7),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Stack(
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
                _buildSignupBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
