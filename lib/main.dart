import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:karate_app/data.dart';
import 'package:karate_app/view/auth/splash_screen.dart';
import 'package:karate_app/view/session_data.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: const FirebaseOptions(
       apiKey: "AIzaSyBgGAYFgMp9dpxqe-Ox05Qn4_0QPqD7vko", 
       appId: "1:713498311290:android:845227e9a0bedd741719c3", 
       messagingSenderId: "713498311290", 
       projectId: "karate-app-537b3"
     )
  );
    await SessionData.getSessionData(); // Fetch the login state

  runApp( const MyApp());
  //staticData();
}
class MyApp extends StatelessWidget{


  const MyApp({super.key,});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}