import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/drawer.dart';
import 'package:karate_app/view/auth/login_screen.dart';
import 'package:karate_app/view/custom_snackbar.dart';
import 'package:karate_app/view/dashboard_screens/courses_screen.dart';
import 'package:karate_app/view/dashboard_screens/book_screen.dart';
import 'package:karate_app/view/dashboard_screens/question_answer_screen.dart';
import 'package:karate_app/view/dashboard_screens/stance_screen.dart';
import 'package:karate_app/view/dashboard_screens/warm_up_screen.dart';
import 'package:karate_app/view/session_data.dart';
import 'package:karate_app/view/tab_bar/news_screen.dart';
import 'package:karate_app/view/tab_bar/profile_screen.dart';

class HomeScreen extends StatefulWidget{

  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState()=> _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

int _selectedIndex = 0;
// String _username="";

  @override
  void initState() {
    super.initState();
    // _loadUsername();
    //fetchCourses();
    setState(() {
      SessionData.userName;
    });
  }

  
  // Function to handle bottom navigation item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of screens to display based on selected tab
  final List<Widget> _screens = [
    const HomeTabScreen(),
    const NewsHomePage(),
    const ProfilePage()
  ];

    @override
    Widget build(BuildContext context){

      return Scaffold(
          appBar:AppBar(
            title:
            //  _username == ""
            // ? const CircularProgressIndicator()
            // :
            Text(
              'Hello, ${SessionData.userName}',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            surfaceTintColor: Colors.white,
            actions: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () async{
                      // await SessionData.clearSessionData();
                      SessionData.storeSessionData(loginData: false, userName: "",userEmailId: "");
                      CustomSnackbar.showCustomSnackbar(message: "Log out sucessfully", context: context);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context){
                          return const LoginScreen();
                        })
                      );
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Icon(Icons.logout)),
                  const SizedBox(width: 20,),
                ],
              ),
            ],
          ),
          drawer: const MyDrawer(),
          body: _screens[_selectedIndex], // Display the selected screen
                  bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  selectedItemColor: const Color.fromARGB(255, 157, 46, 38), // Color when selected
                  unselectedItemColor: Colors.grey, // Color when not selected
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    
                    BottomNavigationBarItem(
                      icon: Icon(Icons.article),
                      label: 'Latest News',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
      );
    }
}

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {

  int _currentIndex = 0;
  int completedDays=15;
  late PageController _pageController;

  final List<String> _imageUrls = [
    'assets/HomeScreenImage/slide_image1.jpg',
    'assets/HomeScreenImage/slide_image2.jpg',
    'assets/HomeScreenImage/slide_image3.jpg',
    'assets/HomeScreenImage/slide_image4.jpg',
    'assets/HomeScreenImage/slide_image5.jpg',
  ];

  @override
  void initState() {
    super.initState();
    fetchCourses();
    _pageController = PageController();  // Initialize PageController

    // Automatically slide after some time (e.g., every 3 seconds)
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < _imageUrls.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0; // Reset to first image
      }

      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(seconds: 1), // Duration of the slide
        curve: Curves.easeInOut, // Curve for the transition
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();  // Properly dispose the controller
    super.dispose();
  }

  // To hold courses data
  List<Map<String, dynamic>> courses = [];

  // Function to fetch courses from Firestore
  Future<void> fetchCourses() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('MyCoursesCollection').get();
      if (snapshot.docs.isNotEmpty) {
        // If courses exist, populate the list
        setState(() {
          courses = snapshot.docs.map((doc) {
            return {
              'courseName': doc['courseName'],
              'imageUrl': doc['imageUrl'],
              'price': doc['price'],
              'courseDuration':doc['courseDuration'],
            };
          }).toList();
        });
        log('$courses');
      } else {
        // If no courses found, reset courses list
        setState(() {
          courses = [];
        });
      }
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
            child: Container(
               margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                      decoration: BoxDecoration(
                        //border: Border.all(),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: PageView.builder(
                controller: _pageController,  // Assigning the controller
                itemCount: _imageUrls.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      _imageUrls[index], // Use images from _imageUrls list
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
                  ),
                  const SizedBox(height: 15,),
                  courses.isEmpty
                  ?const SizedBox()
                  :Text(
                    'My Classes',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                   const SizedBox(height: 15,),
                   courses.isEmpty
                   ?const SizedBox()
                   :SizedBox(
                    height: 200,
                     child: ListView.builder(
                      itemCount: courses.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {

                     int totalDays = courses[index]['courseDuration'];  // Total days for the course
                     log("$totalDays");
                    // Calculate the progress
                     double progress = (completedDays / totalDays).clamp(0.0, 1.0);  // Ensure the value is between 0 and 1

                        return GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context){
                      //   return const TrainingProgressTracker(completedDays: 10);
                      // }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill( 
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(12),
                                                        child: Image.asset(
                                                          courses[index]['imageUrl'], // Your background image
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                  ),
                                                  
                                      ],
                                    ),
                                  ),
                      
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    courses[index]['courseName'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  LinearProgressIndicator(
                                      value: progress, // The progress from 0.0 to 1.0 (0.0 is no progress, 1.0 is complete)
                                      minHeight: 5, // Adjust the height of the progress bar
                                      color: Colors.green, // Set the color of the progress bar
                                      backgroundColor: Colors.grey[300], // Set the background color
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${(progress * 100).toStringAsFixed(0)}% completed', // Display percentage,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                      },
                     ),
                   ),
                  
                  const SizedBox(height: 15,),
                  Text(
                    'Classes',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  SizedBox(
                  height: 200, // Height of the container (adjust as needed)
                  child: ListView(
                    scrollDirection: Axis.horizontal, // Makes the list scroll horizontally
                    children: [
              // First Container with Gradient
              GestureDetector(
                onTap: () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context){
                      return const BegineerLevelScreen();
                    })
                  );
                },
                child: Container(
                  width: 300,
                  margin: const EdgeInsets.only(right: 10), // Space between containers
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.purple], // Gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12), // Optional rounded corners
                  ),
                  child: Stack(
                              children: [
                                     Positioned.fill(
                                        child: Opacity(
                                          opacity: 0.6, // Adjust opacity to make the background semi-transparent
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.asset(
                                              'assets/HomeScreenImage/easy_level.jpg', // Your background image
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    ),
                                    const Positioned(
                                      top: 20,
                                      left: 20,
                                        child:  Center(
                                            child: Text(
                                              'Beginner Level',
                                              style: TextStyle(color: Colors.white, fontSize: 22),
                                            ),
                                          ),
                                    ),
                              ],
                            ),
                ),
              ),
              
              // Second Container with Gradient
              Container(
                width: 300,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.purple], // Gradient colors
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                            children: [
                                   Positioned.fill(
                                      child: Opacity(
                                        opacity: 0.7, // Adjust opacity to make the background semi-transparent
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.asset(
                                            'assets/HomeScreenImage/medium_level.jpg', // Your background image
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                  ),
                                  const Positioned(
                                    top: 20,
                                    left: 20,
                                      child:  Center(
                                          child: Text(
                                            'Intermediate Level',
                                            style: TextStyle(color: Colors.white, fontSize: 22),
                                          ),
                                        ),
                                  ),
                            ],
                          ),
              ),
              
              // Third Container with Gradient
              Container(
                width: 300,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.purple], // Gradient colors
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                            children: [
                                   Positioned.fill(
                                      child: Opacity(
                                        opacity: 0.7, // Adjust opacity to make the background semi-transparent
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.asset(
                                            'assets/HomeScreenImage/hard_level.jpg', // Your background image
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                  ),
                                  const Positioned(
                                    top: 20,
                                    left: 20,
                                      child:  Center(
                                          child: Text(
                                            'Advance Level',
                                            style: TextStyle(color: Colors.white, fontSize: 22),
                                          ),
                                        ),
                                  ),
                            ],
                          ),
              ),
            ],
          ),
                  ),
                  const SizedBox(height: 15,),
                  Text(
                    'Get Started',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  SizedBox(
                  height: 150, // Height of the container (adjust as needed)
                  child: ListView(
                    scrollDirection: Axis.horizontal, // Makes the list scroll horizontally
                    children: [
                        // First Container with Gradient
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, 
                              MaterialPageRoute(builder: (context){
                                  return const WarmUpScreen();
                              })
                            );
                          },
                          child: Container(
                            width: 330,
                            margin: const EdgeInsets.only(right: 10), // Space between containers
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.blue, Colors.purple], // Gradient colors
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12), // Optional rounded corners
                            ),
                            child: Stack(
                              children: [
                                     Positioned.fill(
                                        child: Opacity(
                                          opacity: 0.6, // Adjust opacity to make the background semi-transparent
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.asset(
                                              'assets/HomeScreenImage/warm_up.jpg', // Your background image
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    ),
                                    const Positioned(
                                      bottom: 20,
                                      left: 20,
                                        child:  Center(
                                            child: Text(
                                              'Warm up and Stretch',
                                              style: TextStyle(color: Colors.white, fontSize: 20),
                                            ),
                                          ),
                                    ),
                              ],
                            ),
                            
                          ),
                        ),

                        // First Container with Gradient
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context){
                                return const StanceScreen();
                              })
                            );
                          },
                          child: Container(
                            width: 330,
                            margin: const EdgeInsets.only(right: 10), // Space between containers
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.blue, Colors.purple], // Gradient colors
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12), // Optional rounded corners
                            ),
                            child: Stack(
                              children: [
                                     Positioned.fill(
                                        child: Opacity(
                                          opacity: 0.6, // Adjust opacity to make the background semi-transparent
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.asset(
                                              'assets/HomeScreenImage/stance.png', // Your background image
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    ),
                                    const Positioned(
                                      bottom: 20,
                                      left: 20,
                                        child:  Center(
                                            child: Text(
                                              'Stance',
                                              style: TextStyle(color: Colors.white, fontSize: 20),
                                            ),
                                          ),
                                    ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Text(
                    'Learn from Books',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, 
                              MaterialPageRoute(builder: (context){
                                  return  BookScreen();
                              })
                        );
                    },
                    child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            margin: const EdgeInsets.only(right: 0), // Space between containers
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12), // Optional rounded corners
                              color: Colors.black,
                            ),
                            child: Stack(
                              children: [
                                     Positioned.fill(
                                        child: Opacity(
                                          opacity: 0.5, // Adjust opacity to make the background semi-transparent
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.asset(
                                              'assets/HomeScreenImage/book_image.png', // Your background image
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    ),
                                    const Positioned(
                                      bottom: 20,
                                      left: 20,
                                        child: Text(
                                          'Popular Books',
                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                        ),
                                    ),
                              ],
                            ),
                            
                          ),
                  ),
                        const SizedBox(height: 15,),
                  Text(
                    'Question and Answers',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, 
                        MaterialPageRoute(builder: (context){
                          return const QuestionAnswerScreen();
                        })
                      );
                    },
                    child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            margin: const EdgeInsets.only(right: 0), // Space between containers
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12), // Optional rounded corners
                              color: Colors.black,
                            ),
                            child: Stack(
                              children: [
                                     Positioned.fill(
                                        child: Opacity(
                                          opacity: 0.5, // Adjust opacity to make the background semi-transparent
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.asset(
                                              'assets/HomeScreenImage/knowledge.jpg', // Your background image
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    ),
                                    const Positioned(
                                      bottom: 20,
                                      left: 20,
                                        child: Text(
                                          'Knowledge Lab',
                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                        ),
                                    ),
                              ],
                            ),
                            
                          ),
                  ),
                ],
              ),
            ),
          );
  }
}