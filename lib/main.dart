import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chating/home/home.dart';
import 'package:chating/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCjhtqJiXn0e2ukPuOB7CO_e2xqJEC48rg",
      authDomain: "chating-10ccb.firebaseapp.com",
      projectId: "chating-10ccb",
      storageBucket: "chating-10ccb.appspot.com",
      messagingSenderId: "702955320805",
      appId: "1:702955320805:web:2ac278de85f8665433ab0c",
      measurementId: "G-RHLMX4JH92",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
