import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/dashboard_screens/course_details.dart';
import 'package:karate_app/view/dashboard_screens/payment_screen.dart';

class BegineerLevelScreen extends StatefulWidget {
  const BegineerLevelScreen({super.key});

  @override
  State<BegineerLevelScreen> createState() => _BegineerLevelScreenState();
}

class _BegineerLevelScreenState extends State<BegineerLevelScreen> {

List<Map<String,dynamic>> firebaseCourses=[];

  @override
  void initState(){
    super.initState();
    getFirebaseData();
  }

void getFirebaseData()async{
  QuerySnapshot response=await FirebaseFirestore.instance.collection("MyCoursesCollection").get();
  // Store the Firestore data in a list
    setState(() {
      firebaseCourses = response.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    });

    for(int i=0;i<firebaseCourses.length;i++){
      if(firebaseCourses[i]['courseName']==course[i]['courseName']){
        course[i]['isBuy']=true;
      }
    }
  log("$course");
}
  // List of belts with names and image URLs
    final List<Map<String, dynamic>> course = [
      {'courseName': 'White Belt', 'imageUrl': 'assets/beginner_level_screen/white_belt.jpg','price':'₹ 4000/-','isBuy':false,'courseDuration':56},
      {'courseName': 'Yellow Belt', 'imageUrl': 'assets/beginner_level_screen/yellow_belt.jpg','price':'₹ 4500/-','isBuy':false,'courseDuration':70},
      {'courseName': 'Orange Belt', 'imageUrl': 'assets/beginner_level_screen/orange_belt.jpg','price':'₹ 5000/-','isBuy':false,'courseDuration':90}
      // Add more belts if necessary
    ];


  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Courses',
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
            Icons.navigate_before_outlined,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Using ListView.builder to create the list of belts
              ListView.builder(
                shrinkWrap: true, // To avoid overflow error
                physics: const NeverScrollableScrollPhysics(), // Disable scrolling for inner ListView
                itemCount: course.length,
                itemBuilder: (context, index) {
                  return CourseContainer(
                    courseName: course[index]['courseName']!,
                    imageUrl: course[index]['imageUrl']!,
                    price:course[index]['price']!,
                    isBuy: course[index]['isBuy'],
                    courseDuration: course[index]['courseDuration'],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseContainer extends StatefulWidget {
  final String courseName;
  final String imageUrl;
  final String price;
  final bool isBuy;
  final int courseDuration;

  const CourseContainer({
    super.key,
    required this.courseName,
    required this.imageUrl,
    required this.price,
    required this.isBuy,
    required this.courseDuration,
  });

  @override
  State<CourseContainer> createState() => _CourseContainerState();
}

class _CourseContainerState extends State<CourseContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return  CourseDetailsScreen(
                      courseName: widget.courseName,imageUrl: widget.imageUrl,price: widget.price,isBuy: widget.isBuy,courseDuration: widget.courseDuration,
                    );
                  }),
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
                          widget.imageUrl, // Your background image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.courseName,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Course Duration : ${widget.courseDuration} days",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[600],
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
                    widget.price,
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
             widget.isBuy? const SizedBox()  : Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return  PaymentScreen(
                    courseName: widget.courseName,
                    imageUrl: widget.imageUrl,
                    price: widget.price,
                    courseDuration: widget.courseDuration,
                  );
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
                  color:  widget.isBuy? Colors.grey : Colors.blue[700],
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
      ),
    );
  }
}
