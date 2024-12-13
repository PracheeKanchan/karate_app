import 'package:flutter/material.dart';
import 'package:karate_app/view/auth/splash_screen.dart';
import 'package:karate_app/view/drawer_screens/my_training.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}