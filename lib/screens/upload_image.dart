import 'package:flutter/material.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({ Key? key }) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(appBar: AppBar(title: Text('upload Image to firebase'),centerTitle: true,),
    body: Padding(padding: EdgeInsets.all(20),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(onPressed: (){},icon: Icon(Icons.camera ),label: Text("Camera"),),
             ElevatedButton.icon(onPressed: (){},icon: Icon(Icons.library_add ),label: Text("Gallery"),)
          ],
        ),
      ],
    ),
    ),
    ),
    
     );
  }
}