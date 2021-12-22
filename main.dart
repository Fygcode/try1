
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:try1/indexpage.dart';

Future<void> main() async {
 
  runApp( MaterialApp(    
    theme: ThemeData(primarySwatch: Colors.red),
    debugShowCheckedModeBanner: false ,
    home: const MyApp(),
    
  )
  );
   WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: IndexPage(),
    );
  }
}







