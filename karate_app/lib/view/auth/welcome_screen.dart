import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/auth/login_screen.dart';
import 'package:karate_app/view/auth/register_screen.dart';

class WelcomeScreen extends StatefulWidget{

  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState()=> _LoginScreenState();
}

class _LoginScreenState extends State<WelcomeScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(
                //height:200,
                width: MediaQuery.of(context).size.width,
                //color: Colors.amber,
                child:Image.asset('assets/welcome_logo.png'),
              ),
              //const SizedBox(height: 50,),
              Text(
                '\t\t\tWelcome to \nSenseiConnect',
                style: GoogleFonts.roboto(
                  fontSize: 28,
                  fontWeight: FontWeight.w700
                ),
              ),
              Text(
                'Unleash your potential here',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w400
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context){
                      return const LoginScreen();
                    })
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.black,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child:Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                    child: Text(
                    'Sign in  ',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                                ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context){
                        return const RegisterScreen();
                      })
                    );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.black,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child:Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                    child: Text(
                    'Sign up',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                                ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}