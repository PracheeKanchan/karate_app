import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/auth/onboard_screens/onboard_screen1.dart';
import 'package:karate_app/view/auth/onboard_screens/onboard_screen3.dart';

class OnboardScreen2 extends StatefulWidget{

  const OnboardScreen2({super.key});
  @override
  State createState()=> _OnboardScreen2State();
}
class _OnboardScreen2State extends State<OnboardScreen2>{

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
        
        // Overlay Image (e.g., logo)
        Positioned(
          top: 40,
          left: 30,
          child: SizedBox(
            height: 370,
            width: 370,
            child: Image.asset(
              'assets/onboard_screen2.jpg', // Your overlay image
              width: 100, // You can adjust the size as needed
              height: 100,
            ),
          ),
        ),
        
        
        // Text on top of the image
        Positioned(
          bottom: 290,
          left: 100,
          child: Text(
            'Strength through \n\t\t\t\t\t\tdiscipline.', // Text you want to overlay
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
        Positioned(
          bottom: 160,
          left: 90,
          child: SizedBox(
            child: Text(
              '       Discipline builds the \nmental and physical strength\n \t\t\t\t\t\trequired for mastery.',
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
        ),
        Positioned(
          bottom: 40,
          left: 10,
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context){
                  return const OnboardScreen1();
                })
              );
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: const Icon(
                Icons.navigate_before_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          right: 10,
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context){
                return const OnboardScreen3();
              }));
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: const Icon(
                Icons.navigate_next_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
          
          
      );
  }
}