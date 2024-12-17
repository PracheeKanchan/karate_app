import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/dashboard_screens/payment_screen.dart';



class CourseDetailsScreen extends StatefulWidget {
   CourseDetailsScreen({super.key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
   bool _isExpanded = false;


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Course Details',
           style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
           ),
          ),
      ),
      body: Column(
        children: [
          // Scrollable body
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. First Text
                    Text(
                      'Karate - White belt',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    // 2. Second Text
                    Text(
                      'Exclusive course for white belt',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    // 3. Third Text with Clock Icon
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.blue[600]),
                        const SizedBox(width: 8),
                        Text(
                            'Course duration - 56 days',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                    ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    
                    // 4. Pre-requisite
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Pre-requisite : ',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey[600],
                                ),
                          ),
                          TextSpan(
                            text: 'None',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue[600],
                                ),
                          ),
                        ]
                      )
                      
                    ),
                    const SizedBox(height: 10),
                    
                    // 5. Image Container
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: const BoxDecoration(
                        
                      ),
                      child: Image.asset('assets/beginner_level_screen/white_belt_course.jpg',fit: BoxFit.cover,),
                    ),
                    const SizedBox(height: 20),
                    
                    // 6. Complete Syllabus Section
                    Text(
                      'Complete Syllabus',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    // 7. Yellow Bullets for Syllabus items
                    Row(
                            children: [
                              const Icon(Icons.circle, color: Colors.yellow, size: 10),
                              const SizedBox(width: 8),
                              Text(
                                  '6 Topics',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey[600],
                                  ),
                                ),
                            ],
                    ),
                    const SizedBox(height: 20),
                    
                    // 8. Expandable container section
                    Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Header Row with Circle Image and Text
          Row(
            children: [
              // Text Info
              const Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fitness',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              Spacer(),
              // Down Arrow Button
              IconButton(
                icon: Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ],
          ),
          
          // Expanded Content
          if (_isExpanded)
            const Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('1. Basic Routine.\n2. Leg Stretching )', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 5),
                  
                ],
              ),
            ),
        ],
      ),
    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Non-scrollable Payment Option at the Bottom
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return const PaymentScreen();
              }));
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius:const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
                )
              ),
              child:Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Center(
                      child: Text(
                        'Proceed to payment',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
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

