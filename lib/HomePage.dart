import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser! ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child : Column(
            children: [
              Text("Welcome ${user.email}"),
              ElevatedButton(
                onPressed: () { FirebaseAuth.instance.signOut() ; },
                child: Text("Sign out"),
              ),

            ],
          ),

      ) ,

    );
  }
}

