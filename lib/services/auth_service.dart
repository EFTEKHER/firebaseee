


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseee/screens/home_screen.dart';
import 'package:firebaseee/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//Register user
  Future<User?> Register(
      String email, String password, BuildContext context) async {
    try {
      UserCredential usercredential =
          (await firebaseAuth.createUserWithEmailAndPassword(
              email: email.trim(), password: password));

      return usercredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential usercredential = (await firebaseAuth
          .signInWithEmailAndPassword(email: email.trim(), password: password));
      return usercredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
      )
      );
    } catch (e) {
      print(e);
    }
    return null;
  }
   final GoogleSignIn googleSignIn = GoogleSignIn();
   Future<void> signInwithGoogle(BuildContext context) async {
  
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
       
      // Getting users credential
      UserCredential result = await firebaseAuth.signInWithCredential(authCredential); 
      User? user = result.user;
      
      // ignore: unnecessary_null_comparison
      if (result != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen(user!)));
      }  // if result not null we simply call the MaterialpageRoute,
        // for go to the HomePage screen
    }
 
   }
  Future<void> signOutFromGoogle(BuildContext context) async{
    await firebaseAuth.signOut().then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: ((context) => RegisterScreen())), (route) => false));
    await googleSignIn.signOut();
    
    
    

}
       
      
    
  }




