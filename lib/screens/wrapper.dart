import 'package:brew_crew_new/models/myuser.dart';
import 'package:brew_crew_new/screens/authenticate/authenticate.dart';
import 'package:brew_crew_new/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }

    //return either Home or Authenticate Widget
  }
}
