import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/auth/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardScreen3 extends StatefulWidget{

  const OnboardScreen3({super.key});
  @override
  State createState()=> _OnboardScreen3State();
}
class _OnboardScreen3State extends State<OnboardScreen3>{

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
              'assets/onboard_image/onboard_screen3.jpg', // Your background image
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        // Overlay Image (e.g., logo)
        
        
        
        // Text on top of the image
        Positioned(
          child: Center(
            child: Text(
              '\t\t\t Practice that \n\tproduces results.', // Text you want to overlay
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
          bottom: 220,
          left: 90,
          child: SizedBox(
            child: Text(
              'Consistent, focused practice \nwith intentional effort is the\n key to tangible improvement \nand progress.',
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
          right: 10,
          child: GestureDetector(
            
            onTap: () async{
              // Set 'isFirstTime' to false after onboarding
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isFirstTime', false);
              Navigator.pushReplacement(context, 
                MaterialPageRoute(builder: (context){
                  return const WelcomeScreen();
                })
              );
              //setState(() async{ 
                 
              //});
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