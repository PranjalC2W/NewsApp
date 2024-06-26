import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "view/SignUpPage.dart";

void main() async {
WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options:const  FirebaseOptions(apiKey: "AIzaSyAQ5HDtbXV6dcsYkgenP6RhmZpockS8oHw", appId: "1:248243701685:android:af63d38fa097e2205bfbfc", messagingSenderId: "248243701685", projectId: "newaappproject",)
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:const  SignUpPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(12, 84, 190, 1.0),
          useMaterial3: true,),
    );
  }
}
