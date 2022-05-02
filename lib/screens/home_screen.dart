import '../services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    ));
  }
}
