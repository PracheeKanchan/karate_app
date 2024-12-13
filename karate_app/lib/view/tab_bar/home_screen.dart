import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/drawer.dart';

class HomeScreen extends StatefulWidget{

  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState()=> _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{

int _selectedIndex = 0;

  // Function to handle bottom navigation item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of screens to display based on selected tab
  final List<Widget> _screens = [
    const HomeTabScreen(),
    
  ];

    @override
    Widget build(BuildContext context){

      return Scaffold(
          appBar:AppBar(
            title: Text(
              'Karate',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
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
                      icon: Icon(Icons.model_training),
                      label: 'Training',
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

  

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
            child: Container(
               margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Text(
                    'Class',
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
              Container(
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
                        Container(
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

                        // First Container with Gradient
                        Container(
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
                  Container(
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
                        const SizedBox(height: 15,),
                  Text(
                    'Question and Answers',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
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
                ],
              ),
            ),
          );
  }
}