import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/dashboard_screens/payment_screen.dart';



class CourseDetailsScreen extends StatefulWidget {
   const CourseDetailsScreen({super.key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
   

List<Map> syllabusList=[
  
  {
    'title':'FITNESS',
    'description' : '1. Basic Routine.\n2. Leg Stretching',
    'isExpanded':false
  },
  {
    'title':'KIHONS TRADITIONAL',
    'description' : 'From Zenkutsu Dachi Gedan Barai: -\n1. Step Forward Oi Zuki 5 - Times, Mawatte.\n2. Step Forward Age Uke 5 - Times, Mawatte.\n3. Step Forward Soto Uke 5 - Times, Mawatte.',
    'isExpanded':false
  
  },
  {
    'title':'KIHONS – SPORTS',
    'description' : '1. Gyaku zuki front leg forward and back in two counts\n2. Kizami zuki front forward and back in two counts\n3. Back leg mawashi geri put leg forward and step back',
    'isExpanded':false
  
  },
  {
    'title':'KATA',
    'description' : 'Taikyoku Shodan (Perfect) / Taikyoku Nidan (Basic)',
    'isExpanded':false
  
  },
  {
    'title':'KUMITE',
    'description' : 'Sports Kumite with single technique attack and deffence.',
    'isExpanded':false
  
  },
  {
    'title':'STANCE',
    'description' : 'Zenkutsu Dachi & Kiba Dachi.',
    'isExpanded':false

  },
];
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
          surfaceTintColor: Colors.white,
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
                    ListView.builder(
                      itemCount: syllabusList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header Row with Circle Image and Text
                              Row(
                                children: [
                                  // Text Info
                                   Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          syllabusList[index]['title'],
                                          style:const  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  // Down Arrow Button
                                  IconButton(
                                    icon: Icon(
                                      syllabusList[index]['isExpanded'] ? Icons.expand_less : Icons.expand_more,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        syllabusList[index]['isExpanded'] = !syllabusList[index]['isExpanded'];
                                      });
                                    },
                                  ),
                                ],
                              ),
                              
                              // Expanded Content
                              if (syllabusList[index]['isExpanded'])
                               Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          syllabusList[index]['description'],
                                          style:const  TextStyle(fontSize: 16, ),
                                        ),
                                     const SizedBox(height: 5),
                                      
                                    ],
                                  ),
                                ),
                            ],
                          ),
                                                ),
                        );
                      },
                      
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

