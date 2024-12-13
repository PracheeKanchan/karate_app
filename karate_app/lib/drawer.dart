
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/drawer_screens/my_training.dart';
import 'package:karate_app/view/drawer_screens/reminder_screen.dart';
import 'package:karate_app/view/tab_bar/home_screen.dart';

class MyDrawer extends StatelessWidget{

  const MyDrawer({super.key});
  @override
 Widget build(BuildContext context){
    return Drawer(
        width: (MediaQuery.of(context).size.width) / 2 + 30,
        child: ListView(
          children: <Widget>[
            // Drawer Header
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Karate',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20,bottom: 10),
              child: Text(
                'Unleash your potential',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(0,0,0,0.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Container(
                margin: const EdgeInsets.only(top: 10,),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                  ),
                  color: Color.fromRGBO(14,161,125,0.15),
                ),
                child: ListTile(
                  minVerticalPadding: 10,
                  minTileHeight: 40,
                  leading: const Icon(
                    Icons.home,
                    color:  Color.fromARGB(255, 157, 46, 38),
                  ),
                  title: Text(
                    'Home',
                     style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                     ),  
                  ),
                  onTap: () {
                    
                    // Close the drawer
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10,),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                  ),
                //  color: Color.fromRGBO(14,161,125,0.15),
                ),
                child: ListTile(
                  minVerticalPadding: 10,
                  minTileHeight: 40,
                  leading: const Icon(
                    Icons.model_training,
                    color:  Color.fromARGB(255, 157, 46, 38),
                  ),
                  title: Text(
                    'My Training',
                     style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                     ),  
                  ),
                  onTap: () {
                    // Handle navigation here
                    Navigator.pushReplacement(context, 
                      MaterialPageRoute(builder: (context){
                        return const MyTrainingScreen();
                      })
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                  ),
                  //color: Color.fromRGBO(14,161,125,0.15),
                ),
                child: ListTile(
                  minVerticalPadding: 10,
                  minTileHeight: 40,
                  leading: const Icon(
                    Icons.food_bank_outlined,
                    color: Color.fromARGB(255, 157, 46, 38),
                  ),
                  title: Text(
                    'Meals Plan',
                     style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                     ),  
                  ),
                  onTap: () {
                    
                     // Close the drawer
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10,),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                  ),
                  //color: Color.fromRGBO(14,161,125,0.15),
                ),
                child: ListTile(
                  minTileHeight: 40,
                  minVerticalPadding: 10,
                  leading: const Icon(
                    Icons.notifications,
                    color: Color.fromARGB(255, 157, 46, 38),
                  ),
                  title: Text(
                    'Reminder',
                     style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                     ),  
                  ),
                  onTap: () {
                    // Handle navigation here
                     Navigator.pushReplacement(context, (
                      MaterialPageRoute(builder: (context){
                        return const MyReminderScreen();
                      })
                     ));
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10,),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                  ),
                  //color: Color.fromRGBO(14,161,125,0.15),
                ),
                child: ListTile(
                  minTileHeight: 40,
                  minVerticalPadding: 10,
                  leading: const Icon(
                    Icons.person,
                    color:  Color.fromARGB(255, 157, 46, 38),
                  ),
                  title: Text(
                    'Profile',
                     style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                     ),  
                  ),
                  onTap: () {
                    // Handle navigation here
                    Navigator.pop(context); // Close the drawer
                  },
                ),
              ),
                ],
              ),
            ),
            
            
          ],
        ),
      );
 }

}

