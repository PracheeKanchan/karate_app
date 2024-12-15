import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/tab_bar/home_screen.dart';



class MyTrainingScreen extends StatefulWidget {

  const MyTrainingScreen({super.key});
  @override
  State createState() => _MyTrainingScreen();
}

class _MyTrainingScreen extends State<MyTrainingScreen> {
  List<Map<String, dynamic>> trainingList = [];

  // Controller for TextField inputs in the dialog
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController trainingDaysController = TextEditingController();


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
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
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
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  setState(() {
                    trainingList.add({
                      'title': titleController.text,
                      'description': descriptionController.text,
                      //'days': selectedDays.toInt(),
                    });
                  });
                  // Clear controllers
                  titleController.clear();
                  descriptionController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
                'assets/my_training.jpg',  // Replace with your image
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
                icon: const Icon(Icons.navigate_before_outlined,color: Colors.black,)),
              ),
             
             Positioned(
              left: 70,
              top: 35,
              child: Text(
                'My Training',
                style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
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
                          'Loream Ipsum, dummy data ',
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
                              'Training days',
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
        onPressed: _showAddTrainingDialog,
        tooltip: 'Add Training',
        child: const Icon(Icons.add),
      ),
    );
  }
}
