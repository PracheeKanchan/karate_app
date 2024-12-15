import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                
              ),
              child: Stack(
                children: [
                  Positioned.fill( bottom: 50,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          imageUrl, // Your background image
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                  ),
                                   Positioned(
                                      bottom: 10,     
                                      left: 120,                               
                                      child:  Text(
                                        beltName,
                                        style: const TextStyle(color: Colors.black, fontSize: 20),
                                      ),
                                  ),
                ],
              ),
            );
  }
}

