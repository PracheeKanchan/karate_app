import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/auth/register_screen.dart';
import 'package:karate_app/view/tab_bar/home_screen.dart';

class LoginScreen extends StatefulWidget{

  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState()=> _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

TextEditingController emailController=TextEditingController();
TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 120,),
              Text(
                'Login Here',
                style:GoogleFonts.roboto(
                  fontSize:28,
                  fontWeight:FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15,),
              Text(
                "Welcome back you've\n\t\t\t\t\t\tbeen missed!",
                style:GoogleFonts.roboto(
                  fontSize:16,
                  fontWeight:FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  
                ),
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20,left: 200),
                child: Text(
                  'Forgot your password?',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, 
                      MaterialPageRoute(builder: (context){
                        return const HomeScreen();
                      })
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: const LinearGradient(
                          colors: [
                            Colors.red,
                            Colors.black,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                    ),
                    child: Center(
                      child: Text(
                        'Sign in',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context){
                      return const RegisterScreen();
                    })
                  );
                },
                child: Container(
                  child: Text(
                    'Create new account? Sign Up',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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