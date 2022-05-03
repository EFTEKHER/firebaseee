import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({ Key? key }) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
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
               decoration: InputDecoration(border:OutlineInputBorder()),

             ),
             SizedBox(height: 20,),
              Text('Description',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
             SizedBox(height: 20,),
             TextField(
               minLines: 5,
               maxLines: 15,
               decoration: InputDecoration(border:OutlineInputBorder()),

             ),
            SizedBox(height: 20,),

            Container(height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(onPressed: (){},child: Text('Add note',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(primary: Colors.pink),),
            )
           ],
         ),
      )
       ),  ),
      
    );
  }
}