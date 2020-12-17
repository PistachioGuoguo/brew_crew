import 'package:brew_crew_new/models/brew.dart';
import 'package:brew_crew_new/screens/home/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_new/services/auth.dart';
import 'package:brew_crew_new/services/database.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {


    // bottom sheet of settings 
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(),
        );
      });
    }



    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      catchError: (_,err)=>null, // catch error, self supplemented code for 'no catchError'
        child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: <Widget>[
            
            // setting button
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),

            ),
            
            
            // log out button
            FlatButton.icon(
              label: Text('Log out'),
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
            ),


          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
