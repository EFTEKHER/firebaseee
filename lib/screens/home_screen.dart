import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseee/models/note.dart';
import 'package:firebaseee/screens/add_note_screen.dart';
import 'package:firebaseee/screens/edit_note_screen.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
      body:StreamBuilder(stream:FirebaseFirestore.instance.collection('notes').where('userId',isEqualTo: user.uid).snapshots() ,builder:(context,AsyncSnapshot snapshot){
        if(snapshot.hasData)
        {
if(snapshot.data.docs.length>0)
{
return ListView.builder(itemCount:snapshot.data.docs.length ,itemBuilder:( context,index){
  NoteModel note=NoteModel.fromJson(snapshot.data.docs[index]);
  return  Card(
            color:Color.fromARGB(255, 72, 161, 193),
            elevation: 5,
            margin: EdgeInsets.all(10),
            child:ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              
              title: Text(note.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              subtitle: Text(note.description,overflow: TextOverflow.ellipsis,maxLines: 2,),
              leading: CircleAvatar(radius: 30,backgroundColor: Color.fromARGB(255, 243, 128, 33),child: Padding(padding: EdgeInsets.all(5),child: Text(DateFormat.yMd().format(note.date.toDate(),),)),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditNoteScreen(note) ));
              },
            ),
          );
} , );
}
else{
  return Center(child:Text("No Notes"));
}
        }
        return Center(
          child: CircularProgressIndicator(),
        );

      },),
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
