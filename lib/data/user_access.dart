/// This code is written by Arvind Ganesan  part of Dhanrashi_MVP project



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class DRUserAccess{
  late FirebaseAuth _auth;
  late String? _email = '';
 // final String _password = '';

  DRUserAccess(FirebaseAuth fa)
  {

    this._auth = fa;

  }

  Future createUser(String email,String password) async
  {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (newUser != null) {
        var currentuser = _auth.currentUser!.uid;
        print('UUID is:$currentuser');
        return (currentuser);
      }
    }
    catch (e) {
      print('Exception while creating user $e');
      return 1;
    }
  }


  Future authUser(String email,String password) async
  {
    try {

      final signInResult =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (signInResult!= null) {
        _email = _auth.currentUser!.email;
        return (_auth.currentUser);
      }
    }
    catch(e){
      // print('Exception while signing in $e');
      // return null;
      throw e;
    }
  }

Future<void> resetPassword(String email) async {

    try{
      _auth.sendPasswordResetEmail(email: email);

    }catch(e){
      throw e;
    }

}


  Future getUser() async {

    print(')))))))))))))${_auth.currentUser}');
    if(this._auth.currentUser != null){
      return  _auth.currentUser;
    }
  }

 Future get  email async => _auth.currentUser!.email;

  // String get email async {
  //  return await _auth.currentUser.email;
  // }


}




//
// class ApplicationState extends ChangeNotifier {
//   ApplicationState() {
//     init();
//   }
//
//   Future<void> init() async {
//     await Firebase.initializeApp();
//
//     FirebaseAuth.instance.userChanges().listen((user) {
//       if (user != null) {
//         _loginState = ApplicationLoginState.loggedIn;
//       } else {
//         _loginState = ApplicationLoginState.loggedOut;
//       }
//       notifyListeners();
//     });
//   }
//
//   ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
//   ApplicationLoginState get loginState => _loginState;
//
//   String? _email;
//   String? get email => _email;
//
//   void startLoginFlow() {
//     _loginState = ApplicationLoginState.emailAddress;
//     notifyListeners();
//   }
//
//   void verifyEmail(
//       String email,
//       void Function(FirebaseAuthException e) errorCallback,
//       ) async {
//     try {
//       var methods =
//       await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
//       if (methods.contains('password')) {
//         _loginState = ApplicationLoginState.password;
//       } else {
//         _loginState = ApplicationLoginState.register;
//       }
//       _email = email;
//       notifyListeners();
//     } on FirebaseAuthException catch (e) {
//       errorCallback(e);
//     }
//   }
//
//   void signInWithEmailAndPassword(
//       String email,
//       String password,
//       void Function(FirebaseAuthException e) errorCallback,
//       ) async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on FirebaseAuthException catch (e) {
//       errorCallback(e);
//     }
//   }
//
//   void cancelRegistration() {
//     _loginState = ApplicationLoginState.emailAddress;
//     notifyListeners();
//   }
//
//   void registerAccount(String email, String displayName, String password,
//       void Function(FirebaseAuthException e) errorCallback) async {
//     try {
//       var credential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//       await credential.user!.updateProfile(displayName: displayName);
//     } on FirebaseAuthException catch (e) {
//       errorCallback(e);
//     }
//   }
//
//   void signOut() {
//     FirebaseAuth.instance.signOut();
//   }
// }
//
//

