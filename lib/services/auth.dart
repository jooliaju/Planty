// import 'package:firebase_auth/firebase_auth.dart';
//
//
// class AuthService {
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//
// }

//
//
// try {
// auth.createUserWithEmailAndPassword(
// email: email, password: password);
//
// ///navigate to homepage here
// // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DetailsScreen()));
// }
// catch(e){
// print(e.toString());
// return null;
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:planty_app/models/user.dart';
import 'package:planty_app/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserModel> get user {
    return _auth.authStateChanges().map((User user) =>_userFromFirebaseUser(user)); //returned is a user object or null vlaue if user signs out
  }



  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      User user = result.user;

      //create a new doc for the user with the uID
      print(user.uid);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future createProfile(String username, String avatarUrl, String uid) async{
    
    await DatabaseService(uid: uid).updateUserData("DBY", "i like bonsais");

  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}