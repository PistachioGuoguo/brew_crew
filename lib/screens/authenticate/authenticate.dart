import 'package:brew_crew_new/screens/authenticate/register.dart';
import 'package:brew_crew_new/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
      // sign-in screen, use param 'toggleView' to pass toggleView function
    } else {
      return Register(toggleView: toggleView); // register screen
    }
  }
}
