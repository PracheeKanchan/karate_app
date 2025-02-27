import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/auth/register_screen.dart';
import 'package:karate_app/view/custom_snackbar.dart';
import 'package:karate_app/view/session_data.dart';
import 'package:karate_app/view/tab_bar/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _showPassword = false;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  // Fetch Firestore data asynchronously and return as Future
  Future<List<Map<String, dynamic>>> getFirebaseData() async {
    QuerySnapshot response =
        await FirebaseFirestore.instance.collection("RegisterUserInfo").get();
    
    return response.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 120),
              Text(
                'Login Here',
                style: GoogleFonts.roboto(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Welcome back you've\n\t\t\t\t\t\tbeen missed!",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: passwordController,
                  obscureText: _showPassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(
                        (_showPassword) ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () async {
                    if (emailController.text.trim().isNotEmpty &&
                        passwordController.text.trim().isNotEmpty) {
                      try {
                        UserCredential userCredential =
                            await _firebaseAuth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        // Fetch the user data after successful login using FutureBuilder
                        List<Map<String, dynamic>> registerInfoList = await getFirebaseData();

                        bool userFound = false;
                        for (int i = 0; i < registerInfoList.length; i++) {
                          if (registerInfoList[i]['UserEmail'] == emailController.text.trim()) {
                            await SessionData.storeSessionData(
                              loginData: true,
                              userName: registerInfoList[i]['UserName'],
                              userEmailId: registerInfoList[i]['UserEmail'],
                            );
                            userFound = true;
                            break;
                          }
                        }

                        if (userFound) {
                          log(SessionData.userName); // Log the username for debugging
                          log(SessionData.userEmailId);
                          // Navigate to HomeScreen after successful login
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return const HomeScreen();
                              },
                            ),
                          );

                          CustomSnackbar.showCustomSnackbar(
                              message: 'Login Successfully', context: context);
                        } else {
                          CustomSnackbar.showCustomSnackbar(
                              message: 'User not found', context: context);
                        }
                      } on FirebaseAuthException catch (error) {
                        CustomSnackbar.showCustomSnackbar(
                            message: error.code, context: context);
                      }
                    } else {
                      CustomSnackbar.showCustomSnackbar(
                          message: 'Please fill in all fields', context: context);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: const LinearGradient(
                        colors: [Colors.red, Colors.black],
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
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const RegisterScreen();
                  }));
                },
                child: SizedBox(
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
