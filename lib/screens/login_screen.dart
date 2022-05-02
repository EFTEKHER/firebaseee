import '../screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../services/auth_service.dart';
class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
   TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();
bool loading =false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: AppBar(title: Text('LogIn'),centerTitle: true, backgroundColor: Colors.blue, ),
    body: Padding(padding: EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
            controller: emailController,
            decoration: InputDecoration(
              label: Text("Email:"),
              border: OutlineInputBorder()
            )
          ),
          SizedBox(height: 30,),
          TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              label: Text("Password:"),
              border: OutlineInputBorder()
            )
          ),
           SizedBox(height: 30,), 
           loading?CircularProgressIndicator():Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(onPressed: () async{
               if(mounted)setState(() {
                loading=true;
              });
              if(emailController.text=="" ||passwordController.text=="")
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required '), backgroundColor: Colors.redAccent,));
              }
             
              else
              {
           User? result=     await AuthService().login(emailController.text, passwordController.text,context);
           if(result!=null)
           {
             print("Success");
             print(result.email);
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => HomeScreen())), (route) => false);
             
           }

              } 
              if(mounted)setState(() {
                loading=false;
              });
            },child: Text("Submit",style:TextStyle(fontStyle: FontStyle.italic,fontSize: 25)),),
          ),
      ],
    ),
    
    ),
    
    )
    );
  }
}