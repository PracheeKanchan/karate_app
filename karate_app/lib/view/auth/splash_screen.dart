import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/auth/onboard_screens/onboard_screen1.dart';

class SplashScreen extends StatefulWidget{

  const SplashScreen({super.key});
  @override
  State createState()=> _SplashScreen();
}
class _SplashScreen extends State<SplashScreen>{

    @override
  void initState() {
    super.initState();
    // Navigate to the onboard screen after 3 seconds
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardScreen1()),
      );
    });
  }
    @override
    Widget build(BuildContext context){
      return Scaffold(
        backgroundColor: Colors.black,
         body: Stack(
      children: [
        // Background Image with Transparency
        Positioned.fill(
          child: Opacity(
            opacity: 0.5, // Adjust opacity to make the background semi-transparent
            child: Image.asset(
              'assets/splash_image.jpg', // Your background image
              fit: BoxFit.cover,
            ),
          ),
        ),
      
        // Text on top of the image
        Positioned(
          
          child: Center(
            child: Text(
              'MARTIAL ARTS \n  IS ONLY THE \nBEGINNING.....', // Text you want to overlay
              style:GoogleFonts.roboto(
                  fontSize: 27,
                fontWeight: FontWeight.w600,
                color: Colors.white, // You can choose another color
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.7),
                    offset:const Offset(5.0, 5.0),
                  ),
                ],
              )
               
            ),
          ),
        ),
        Positioned(
          bottom: 270,
          left: 70,
          child: Text(
            'Strength in every strike,Honor in\n                every move', // Text you want to overlay
            style:GoogleFonts.roboto(
                fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white, // You can choose another color
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black.withOpacity(0.7),
                  offset:const Offset(5.0, 5.0),
                ),
              ],
            )
             
          ),
        ),
        Positioned(
          bottom: 60,
          left: 80,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 30),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context){
                      return const OnboardScreen1();
                    })
                );
              },
              child: Container(
                //height: 50,
                //width: 50,
                padding: const EdgeInsets.symmetric(vertical:15,horizontal: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white),
                ),
                child: Text(
                  "Get's Started",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
          
          
      );
    }
}