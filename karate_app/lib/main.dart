import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child:Text("HelloWorld"),
        ),
      ),
    );
  }
}