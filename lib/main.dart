// ignore: prefer_const_constructors
import '../screens/home_screen.dart';
import '../screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../services/auth_service.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hello",
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home:  StreamBuilder(stream: AuthService().firebaseAuth.authStateChanges()    ,builder: ((context, snapshot) {
        if(snapshot.hasData)
        {
          return HomeScreen();
        }
        
          return RegisterScreen();
        
      }),)
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: Scaffold(appBar: AppBar(title:  Text("FIREBASE "),
//   ),
//    body: Center(child: Text("Hello World")) 
//     )
    
//     );
//   }
// }