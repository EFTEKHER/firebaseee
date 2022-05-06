import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({ Key? key }) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  FirebaseStorage firebasestorage=FirebaseStorage.instance;
  bool loading=false;
  Future<void>uploadImage(String inputSource)async
  {
final picker=ImagePicker();
 final XFile? pickedImage=  await picker.pickImage(source: inputSource=='camera'?ImageSource.camera :ImageSource.gallery );
 if(pickedImage==null)
 {
   return null;
 }
 String fileName=pickedImage.name;
 File imageFile=File(pickedImage.path);
 File compresedFile=await compressImage(imageFile);

 try{
   setState(() {
     loading=true;
   });
  //  await firebasestorage.ref(fileName).putFile(imageFile);
  await firebasestorage.ref(fileName).putFile(compresedFile);
   setState(() {
     loading=false;
   });
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully Uploaded'),));
 }on FirebaseException catch(e)
 {
   print(e);
 }
 catch(error){
print(error);
 }
  }

  Future <List> loadImages()async
  {
List<Map>files=[];
final ListResult result=await firebasestorage.ref().listAll();
final List<Reference>allFiles=result.items;
await Future.forEach(allFiles, (Reference file)async{
  final String fileUrl=await file.getDownloadURL();
  files.add(
    {
      "url":fileUrl,
      "path":file.fullPath,
    }
  );

}) ;
print(files);
return files;
  }

  Future<void>delete(String ref)async
{
await firebasestorage.ref(ref).delete();
setState(() {
  
});
} 
Future <File> compressImage(File file)async{
File compressedFile= await FlutterNativeImage.compressImage(file.path,quality: 30);
print('orginal file size');
print(file.lengthSync());
print('Compressed file length');
print(compressedFile.lengthSync());
return compressedFile;

}

 @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(appBar: AppBar(title: Text('upload Image to firebase'),centerTitle: true,),
    body: Padding(padding: EdgeInsets.all(20),
    child: Column(
      children: [
       loading?Center(child: CircularProgressIndicator(),): Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(onPressed: ()async{
              uploadImage('camera');
            },icon: Icon(Icons.camera ),label: Text("Camera"),),
             ElevatedButton.icon(onPressed: ()async{
               uploadImage('gallery');
             },icon: Icon(Icons.library_add ),label: Text("Gallery"),)
          ],
        ),
        SizedBox(height:50),
        Expanded(child:
        FutureBuilder(future: loadImages(),builder: (context,AsyncSnapshot snapshot){
          if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(itemCount: snapshot.data.length??0  ,itemBuilder:(context,index){
            final Map image=snapshot.data[index];
            return Row(
              children: [
                Expanded(child:
                Card(
                  child: Container(
                    height: 200,
                    child: CachedNetworkImage(imageUrl: image['url'],placeholder: (context,url)=>Image.asset('images/placeholder.jpg'),
                   errorWidget: (context,url,error)=>Icon(Icons.error), 
                    ),
                  ),
                ),
                
                 ),
                 IconButton(onPressed: ()async{
                   await delete(image['path']);
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image Deleted successfully')));
                 }, icon: Icon(Icons.delete,color:Colors.red)),
              ],
            );
          } );
        },) ),
      ],
    ),
    ),
    ),
    
     );
  }
}