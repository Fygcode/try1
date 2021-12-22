// ignore_for_file: file_names, non_constant_identifier_names



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

   User? user = FirebaseAuth.instance.currentUser;





  @override
  Widget build(BuildContext context) {
     // ignore: unnecessary_new
     return new StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if (!snapshot.hasData) {
          return const Text("Loading");
        }
        var userDocument = snapshot.data;
        return Scaffold(
          body: Center(
            child: Text(userDocument["email"]),
          ),
        );
      }
  );
  }
}