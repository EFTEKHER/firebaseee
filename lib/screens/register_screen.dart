import 'package:firebaseee/screens/home_screen.dart';

import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController confirmPasswordController=TextEditingController();
bool loading =false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(appBar: AppBar(title: Text("Register"),
    centerTitle: true,
    backgroundColor: Colors.orangeAccent,
    
    ),
    body: SingleChildScrollView(child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 80,),
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
          TextField(
            obscureText: true,
            controller: confirmPasswordController,
            decoration: InputDecoration(
              label: Text("Confirm Password:"),
              border: OutlineInputBorder()
            )
          ),
          SizedBox(height: 30,),
    loading?CircularProgressIndicator():Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(onPressed: () async{
             if(mounted) setState(() {
                loading=true;
              });
              if(emailController.text=="" ||passwordController.text=="")
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required '), backgroundColor: Colors.redAccent,));
              }
              else if(passwordController.text!=confirmPasswordController.text)
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("passwords don't match "), backgroundColor: Colors.redAccent,));
              }
              else
              {
           User? result=     await AuthService().Register(emailController.text, passwordController.text,context);
           if(result!=null)
           {
             print("Success");
            // print(result.email);
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: ((context) => HomeScreen(result))), (route) => false);
           }

              } 
            if(mounted)setState(() {
                loading=false;
              });

            },child: Text("Submit",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),),
          ),
          SizedBox(height: 20,),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: ((context) => LogIn())));
          }, child: Text("Already have an account?Login here"))
          ,
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),
       loading?CircularProgressIndicator():  SignInButton(Buttons.Google,text: "Continue with Google", onPressed: ()async{
        if(mounted) setState(() {
                loading=true;
              });
await AuthService().signInwithGoogle(context);
if(mounted)setState(() {
                loading=false;
              });
          })
        ],
      ),
    ),
    
    )
    )
    
    );
    
  }
}
