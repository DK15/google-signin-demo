import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sign In',
      home: Scaffold(
        body: GoogleLogin(),
      ),
    );
  }
}

class GoogleLogin extends StatefulWidget {

  @override
  GoogleLoginState createState() => new GoogleLoginState();

}

class GoogleLoginState extends State<GoogleLogin> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  final GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly'
    ],
  );

  @override
  Widget build(BuildContext context) {

    return Center(
      child: RaisedButton(
        onPressed: () => _handleGoogleSignIn(),
        child: Text('Google Sign In'),
      ),
    );
  }

  Future<Null> _handleGoogleSignIn() async {

    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

    var googleAuth = await googleSignInAccount.authentication;

    firebaseUser = await _auth.signInWithGoogle(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

  }

}


