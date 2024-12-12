import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/auth/onboard_screens/onboard_screen2.dart';
import 'package:karate_app/view/auth/splash_screen.dart';

class OnboardScreen1 extends StatefulWidget{

  const OnboardScreen1({super.key});
  @override
  State createState()=> _OnboardScreen1State();
}
class _OnboardScreen1State extends State<OnboardScreen1>{

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
        // Text on top of the image
        Positioned(
          
          child: Center(
            child: Text(
              'Discipline Creates \n\t\t\t\t\t\t\t\tStrength,\n Strength Creates \n\t\t\t\t\t\t\t\tVictory.', // Text you want to overlay
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
          bottom: 200,
          left: 60,
          child: SizedBox(
            child: Text(
              '''\t\t\t\tDiscipline yourself to excel in\n\t\t\t\tcollegiate martial arts ; rapidly \n  \t\tenhance skills, but your\n\t\t\t\tcommitment drives success''',
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
                  return const SplashScreen();
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
            onTap: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context){
                return const OnboardScreen2();
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