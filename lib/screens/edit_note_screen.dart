import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseee/models/note.dart';
import 'package:firebaseee/services/firestore_service.dart';
import 'package:flutter/material.dart';
import '../services/firestore_service.dart';


// ignore: must_be_immutable
class EditNoteScreen extends StatefulWidget {
  NoteModel note;
  EditNoteScreen(this.note);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  bool loading=false;
  @override
  void initState() {
    
    titleController.text=widget.note.title;
    descriptionController.text=widget.note.description;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(backgroundColor: Colors.transparent,elevation:0 ,actions: [
        IconButton(onPressed: ()async{

          await showDialog(context: context, builder: (BuildContext content){
              return AlertDialog(
                title: Text("Please confirm"),
                content: Text('Are you want to delete the note?'),
                actions: [
                  TextButton(onPressed: ()async{
                    await FirestoreService().deleteNote(widget.note.id);
                    //close the dialog
                    Navigator.pop(context);
                    //close the edit screen
                    Navigator.pop(context);
                  }, child: Text("Yes")),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("No"))
                ],
              );
          });
        }, icon: Icon(Icons.delete,color: Colors.red,)),
      ], ),
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

          loading?Center(child :CircularProgressIndicator(),):    Container(height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(onPressed: ()async{
if(titleController.text==""||descriptionController.text=="")
{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fileds are required !')));
}
else
{
  setState(() {
  loading=true;
});
await FirestoreService().updateNote(widget.note.id, titleController.text, descriptionController.text);
setState(() {
  loading=false;
});
Navigator.pop(context);
}

            },child: Text('update note',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(primary: Colors.pink),),
            )
           ],
         ),
      )
       ),  ),
      
    );
  }
}