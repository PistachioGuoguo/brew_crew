import 'package:brew_crew_new/models/myuser.dart';
import 'package:brew_crew_new/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FireBaseUser

  MyUser _myUserFromUser(FirebaseUser user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream

  Stream<MyUser> get user {
    return _auth.onAuthStateChanged.map(_myUserFromUser);
  }


  // sign in anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _myUserFromUser(user); // convert to custom User class
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _myUserFromUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password
   Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
      return _myUserFromUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }


  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
