import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseee/services/firestore_service.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
 User user;
AddNoteScreen(this.user);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  bool loading=false;
  @override
  
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(backgroundColor: Colors.transparent,elevation:0 ),
       body: SingleChildScrollView(
         child:Padding(padding: EdgeInsets.all(20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text('Title',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
             SizedBox(height: 20,),
             TextField(
               controller: titleController,
               decoration: InputDecoration(border:OutlineInputBorder()),

             ),
             SizedBox(height: 20,),
              Text('Description',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
             SizedBox(height: 20,),
             TextField(
               controller: descriptionController,
               minLines: 5,
               maxLines: 1000,
               decoration: InputDecoration(border:OutlineInputBorder()),

             ),
            SizedBox(height: 20,),

          loading?Center(child :CircularProgressIndicator(),):  Container(height: 50,
              
              width: MediaQuery.of(context).size.width,
              child:  ElevatedButton(onPressed: ()async{
                  if(titleController==""||descriptionController=="")
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fileds are required !')));
                  }
                  else{
setState(() {
  loading=true;
});
await FirestoreService().insertNote( titleController.text , descriptionController.text, widget.user.uid);
setState(() {
  loading=false;
});
Navigator.pop(context);
                  }

              },child: Text('Add note',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(primary: Colors.pink),),
              ),
            
           ],
         ),
      )
       ),  ),
      
    );
  }
}