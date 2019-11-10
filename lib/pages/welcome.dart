import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laundro/components/rounded_button.dart';


class WelcomeScreen extends StatefulWidget {

  
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>{
  final _auth=FirebaseAuth.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.jpg'),
                    height: 80,
                  ),
                ),
                Text(
                    'Laundro',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Login',
              color: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
            ),
            RoundedButton(
              title: 'Google',
              color: Colors.lightBlueAccent,
              onPressed: () async{
                try{
                  GoogleSignInAccount account = await _googleSignIn.signIn();
                  AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
                  idToken: (await account.authentication).idToken,
                  accessToken: (await account.authentication).accessToken,
                  ));
                  if(res!=null){
                    Navigator.pushNamed(context, "/home");
                  }
                  else{
                    print("error logging in with google");
                    account.clearAuthCache();
                  }
                }
                catch(e){
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

