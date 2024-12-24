import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/auth/login_screen.dart';
import 'package:karate_app/view/custom_snackbar.dart';

class RegisterModelClass{

  String name;
  String mailId;
  String password;

  RegisterModelClass({
    required this.name,
    required this.mailId,
    required this.password,
  });
}

class RegisterScreen extends StatefulWidget{

  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState()=> _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{

TextEditingController userNnameController=TextEditingController();
TextEditingController emailController=TextEditingController();
TextEditingController passwordController=TextEditingController();

List<RegisterModelClass> registerUserList=[];

 bool _showPassword = false;

final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;


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
                'Create account',
                style:GoogleFonts.roboto(
                  fontSize:28,
                  fontWeight:FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15,),
              Text(
                "Create an account and explore much more",
                style:GoogleFonts.roboto(
                  fontSize:16,
                  fontWeight:FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: userNnameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter username',
                    border: OutlineInputBorder(),
                    prefixIcon:Icon(Icons.person,),
                  ),
                  
                ),
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon:Icon(Icons.email,),
                  ),
                  
                ),
              ),
              const SizedBox(height: 30,),
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
                                      _showPassword = !_showPassword;
                                      setState(() {});
                                  },
                                  child: Icon(
                                      (_showPassword) ? Icons.visibility_off :
                                      Icons.visibility,
                                  ),
                              ),
                  ),
                  
                ),
              ),
              
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: ()async{
                    if(userNnameController.text.trim().isNotEmpty && emailController.text.trim().isNotEmpty &&
                            passwordController.text.trim().isNotEmpty  ){
                
                              try{
                                  UserCredential userCredential= await _firebaseAuth.createUserWithEmailAndPassword(
                                        email: emailController.text.trim(),
                                        password: passwordController.text.trim(),
                                    );
                                   
                                        Map<String,dynamic> data={
                                          'UserName':userNnameController.text.trim(),
                                          'UserEmail':emailController.text.trim(),
                                          'UserPassword':passwordController.text.trim(),
                                        };
                      
                                        //add data to firebase
                                        FirebaseFirestore.instance.collection("RegisterUserInfo").add(data);
                                        //setState(() { });                                     

                                        //clear Controllers
                                        userNnameController.clear();
                                        emailController.clear();
                                        passwordController.clear();
                
                                    CustomSnackbar.showCustomSnackbar(message: "Register sucessfully", context: context);
                                    //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data Added'), ), );
                                    
                                    Navigator.of(context).pop();
                
                              }on FirebaseAuthException  catch(error){
                
                                  CustomSnackbar.showCustomSnackbar(message: error.message!, context: context);
                              }
                
                        }else{
                            CustomSnackbar.showCustomSnackbar(message: "Please Enter valid data", context: context);
                        }
                
                  //   Navigator.pushReplacement(context,
                  //   MaterialPageRoute(builder: (context){
                  //     return const LoginScreen();
                  //   })
                  // );
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
                        'Sign up',
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
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context){
                      return const LoginScreen();
                    })
                  );
                },
                child: SizedBox(
                  child: Text(
                    'Already have an account',
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