import 'package:brew_crew_new/models/myuser.dart';
import 'package:brew_crew_new/services/database.dart';
import 'package:brew_crew_new/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_new/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context); // know current user

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {

        UserData userData = snapshot.data;

        if (snapshot.hasData){
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Update your brew settings', style: TextStyle(fontSize: 18),),

                SizedBox(height: 20,),

                // name form field
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),

                ),

                SizedBox(height: 20,),

                //dropdown

                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  onChanged: (val) => setState(() => _currentSugars = val),
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  
                ),

                
                SizedBox(height: 20,),


                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.grey[100],
                  min: 100,
                  max:900,
                  divisions: 8,
                  onChanged: (val) => setState(() =>_currentStrength = val.round()),

                ),

                //slider for strength


                SizedBox(height: 20,),

                RaisedButton(
                  color: Colors.pink[400],
                  child: Text('Update', style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){ // if valid input
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars, 
                        _currentName ?? userData.name, 
                        _currentStrength ?? userData.strength);
                    }
                    Navigator.pop(context);
                  },
                ),


              ],),  
          );
        }else{
          return Loading(); // loading screen
        }

        
      }
    );
  }
}
