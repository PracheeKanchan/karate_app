import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/tab_bar/home_screen.dart';



class MyReminderScreen extends StatefulWidget {

  const MyReminderScreen({super.key});
  @override
  State createState() => _MyReminderScreen();
}

class _MyReminderScreen extends State<MyReminderScreen> {
  List<Map<String, dynamic>> trainingList = [];

  // Controller for TextField inputs in the dialog
  TextEditingController titleController = TextEditingController();
  TextEditingController trainingDaysController = TextEditingController();
  TextEditingController timeController = TextEditingController();



  void _showAddTrainingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Training"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Training name',
                    border: OutlineInputBorder(),
                  ),
                  
                ),
                
                const SizedBox(height: 20),

                TextField(
                  controller: trainingDaysController,
                  decoration: const InputDecoration(
                    hintText: 'Training Days',
                    border: OutlineInputBorder(),
                  ),
                  
                ),
                const SizedBox(height: 20),
                
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel action
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // OK action, add data to list
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

TimeOfDay selectedTime = const TimeOfDay(hour: 12, minute: 0);  // Default time is 12:00 PM
  //List<bool> selectedDays = [false, false, false, false, false, false, false];  // For 7 days (Mon to Sun)

  // Method to show time picker dialog
  void _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
      //_showDaysDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        toolbarHeight: 180,
        flexibleSpace: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              child: Image.asset(
                'assets/reminder.jpg',  // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
             Positioned(
              left: 10,
              top: 30,
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context){
                        return const HomeScreen();
                    })
                  );
                }, 
                icon: const Icon(Icons.navigate_before_outlined,color: Colors.white,)),
              ),
             
             Positioned(
              left: 70,
              top: 35,
              child: Text(
                'Reminder',
                style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                )
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,  // Prevents default back button
      ),
      body: ListView.builder(
        itemCount: 2,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                  //height: 100,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0,7),
                        blurRadius: 8,
                        spreadRadius: 0,
                        color: Color.fromARGB(255, 237, 193, 245),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          'Loream Ipsum',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      Container(
                        padding:const EdgeInsets.only(top: 3,bottom: 5),
                        child: Text(
                          'Timer ',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            child: Text(
                              'Reminder Time',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Row(
                            children: [
                               Icon(Icons.edit_outlined,size: 20,),
                               SizedBox(width: 20,),
                               Icon(Icons.delete_outline,size: 20,),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
              ),
            );
        },
         
      ),
        
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _selectTime(context);
        },
        tooltip: 'Add Reminder',
        child: const Icon(Icons.add),
      ),
    );
  }
}
