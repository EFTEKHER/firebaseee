import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseee/screens/add_note_screen.dart';
import 'package:firebaseee/screens/edit_note_screen.dart';

import '../services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  User user;
HomeScreen(this.user);
  State<HomeScreen> createState() => _HomeScreenState(user);
}

class _HomeScreenState extends State<HomeScreen> {
   

  
  @override
   User user;
  _HomeScreenState(this.user);
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          TextButton.icon(
              onPressed: () async {
              await  AuthService(). signOutFromGoogle(context);
              },
              icon: Icon(Icons.login),
              label: Text("Sign out"),
              style: TextButton.styleFrom(primary: Colors.white))
        ],
      ),
      body:ListView(
        children: [
          Card(
            color:Colors.teal,
            elevation: 5,
            margin: EdgeInsets.all(10),
            child:ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              title: Text('App',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              subtitle: Text('Learn to build a udemy app ',overflow: TextOverflow.ellipsis,maxLines: 2,),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditNoteScreen() ));
              },
            ),
          ),
        ],
      ),
floatingActionButton: FloatingActionButton(onPressed: (){
  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>AddNoteScreen(user) ));
},
backgroundColor: Colors.orangeAccent,
child: Icon(Icons.add)

),
     
    )
    );
  }
}
