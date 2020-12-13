import 'package:brew_crew_new/models/myuser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FireBaseUser

  MyUser _myUserFromUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream

  Stream<MyUser> get user {
    return _auth.authStateChanges().map(_myUserFromUser);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _myUserFromUser(user); // convert to custom User class
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in anonymously

  // sign in with email and password

  // register with email and password

  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
