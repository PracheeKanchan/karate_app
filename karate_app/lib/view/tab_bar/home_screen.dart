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
                      icon: Icon(Icons.fitness_center),
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

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({super.key});

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
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)
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
                  Container(
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
                child: const Center(
                  child: Text(
                    'Beginner Level',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              
              // Second Container with Gradient
              Container(
                width: 300,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.orange, Colors.yellow],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Intermediate Level',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              
              // Third Container with Gradient
              Container(
                width: 300,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.green, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Advance Level',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
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
                  Container(
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
                          child: const Center(
                            child: Text(
                              'Warm up and Stretch',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
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
                          child: const Center(
                            child: Text(
                              'Stance',
                              style: TextStyle(color: Colors.white, fontSize: 20),
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
                                            'assets/HomeScreenImage/knowledge.png', // Your background image
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