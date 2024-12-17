import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/dashboard_screens/course_details.dart';
import 'package:karate_app/view/dashboard_screens/payment_screen.dart';

class BegineerLevelScreen extends StatelessWidget {
  const BegineerLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Begineer Level',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          
          child: const Icon(
            Icons.navigate_before_outlined, color: Colors.black, size: 30,
          ),
        ),
      ),
      body:  const Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              BeltContainer(
                beltName: 'White Belt',
                imageUrl: 'assets/beginner_level_screen/white_belt.jpg', // Path to your image
              ),
               SizedBox(height: 20,),
              BeltContainer(
                beltName: 'Yellow Belt',
                imageUrl: 'assets/beginner_level_screen/yellow_belt.jpg', // Path to your image
              ),
              SizedBox(height: 20,),
              BeltContainer(
                beltName: 'Orange Belt',
                imageUrl: 'assets/beginner_level_screen/orange_belt.jpg', // Path to your image
              ),
              SizedBox(height: 20,),
              
            ],
          ),
        ),
      ),
    );
  }
}

class BeltContainer extends StatelessWidget {
  final String beltName;
  final String imageUrl;

  const BeltContainer({
    super.key,
    required this.beltName,
    required this.imageUrl,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      
       decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,   
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context){
                  return const CourseDetailsScreen();
                })
              );
            },
            child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill( 
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image.asset(
                                                  imageUrl, // Your background image
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                          ),
                                           
                        ],
                      ),
                    ),
          ),
        
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          beltName,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                                TextSpan(
                                  text: '6 ',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue,
                                    ),
                                ),
                                TextSpan(
                                  text: 'Topics',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey[600],
                                    ),
                                ),
                            ],
                          ),
                        ),
                        Text(
                          '₹ 4000/-',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                        return const PaymentScreen();
                      }));
                    },
                    child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                              color: Colors.blue[700],
                            ),
                            child: Center(
                              child: Text(
                                    'Buy Now',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
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

