import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  @override
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

      body: Container(width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
ElevatedButton(onPressed: ()async
{
  //create random id
  // CollectionReference users=firestore.collection('users');
  // await users.add({'name':'Efte'});
  CollectionReference users=firestore.collection('users');
  await users.doc('flutter 123').set({
    'name':'Tonmoy'
  });

}, child: Text("Add Data To Firestore")),

ElevatedButton(onPressed: ()async{
//for read all value
   CollectionReference users=firestore.collection('users');
  // QuerySnapshot allResults = await users.get();
  // allResults.docs.forEach((DocumentSnapshot results) { 
  //   print(results.data());
 // });

 //for read particular element
 DocumentSnapshot result=await users.doc('flutter 123').get();
 print(result.data());

}, child: Text('Read Data from Firestore'))
        ],
        
      ),
      
      ),
    ));
  }
}
