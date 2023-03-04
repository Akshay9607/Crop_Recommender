import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CustomData extends StatefulWidget {

  // const CustomData({Key? key}) : super(key: key);
CustomData({required this.app});
late final FirebaseApp app ;
  @override
  State<CustomData> createState() => _CustomDataState();
}

class _CustomDataState extends State<CustomData> {

final referenceDatabase = FirebaseDatabase.instance;
final moviename = 'MovieTitle';
final movieController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.ref();
    return Scaffold(
      appBar: AppBar(
        title: Text("Best Movies to Watch !! "),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                color: Colors.blue[600],
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Text(
                      moviename,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: movieController,
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                        onPressed: () {
                          ref.child("Movies").push().child(moviename).set(movieController.text).asStream();
                        },
                       child: Text(
                           "Save Movie",
                       ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
