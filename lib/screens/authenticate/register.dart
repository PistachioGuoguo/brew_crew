import 'package:brew_crew_new/shared/constants.dart';
import 'package:brew_crew_new/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_new/services/auth.dart';


class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  
  String error = '';
  bool loading = false;

  String email = '';
  String passwd = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text('Sign up to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              
              //email field
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
              ),
              SizedBox(height: 20),
              
              // password field
              TextFormField(
                validator: (val) => val.length < 6 ? 'Password should have at least 6 digits' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => passwd = val);
                },
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
              ),
              
              SizedBox(height: 20),
              
              // register button
              RaisedButton(
                color: Colors.pink[400], 
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, passwd);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Please supply a valid email';
                      });
                    }
                  }
                },
              ),
               
              SizedBox(height: 12.0),

              // Error field
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0)),
            ],
          ),
        ),
      ),
    );
  }
}
