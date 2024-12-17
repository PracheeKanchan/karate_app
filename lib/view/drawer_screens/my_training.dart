import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/tab_bar/home_screen.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;

  // Create the database and a table for storing training data
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    String path = p.join(await getDatabasesPath(), 'training.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        '''CREATE TABLE trainings(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          days INTEGER
        )''',
      );
    });
  }

  // Insert a training record into the database
  Future<void> insertTraining(Map<String, dynamic> training) async {
    final db = await database;
    await db.insert(
      'trainings',
      training,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all trainings from the database
  Future<List<Map<String, dynamic>>> getTrainings() async {
    final db = await database;
    return await db.query('trainings');
  }

  // Delete a training by id
  Future<void> deleteTraining(int id) async {
    final db = await database;
    await db.delete(
      'trainings',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}


class MyTrainingScreen extends StatefulWidget {
  const MyTrainingScreen({super.key});
  @override
  State createState() => _MyTrainingScreen();
}

class _MyTrainingScreen extends State<MyTrainingScreen> {
  
  List<Map<String, dynamic>> trainingList = [];
  final DBHelper _dbHelper = DBHelper(); // Instantiate DBHelper

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController trainingDaysController = TextEditingController();

  // Fetch trainings from the database
  void _loadTrainings() async {
    List<Map<String, dynamic>> trainings = await _dbHelper.getTrainings();
    setState(() {
      trainingList = trainings;
    });
  }

  // Show dialog to add new training
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
              onPressed: () async {
                // Add training to the database
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    trainingDaysController.text.isNotEmpty) {
                  await _dbHelper.insertTraining({
                    'title': titleController.text,
                    'description': descriptionController.text,
                    'days': int.tryParse(trainingDaysController.text) ?? 0,
                  });

                  // Clear controllers and reload data
                  titleController.clear();
                  descriptionController.clear();
                  trainingDaysController.clear();
                  Navigator.of(context).pop();
                  _loadTrainings(); // Reload the list
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Delete a training record from the database
  void _deleteTraining(int id) async {
    await _dbHelper.deleteTraining(id);
    _loadTrainings(); // Reload the list after deletion
  }

  @override
  void initState() {
    super.initState();
    _loadTrainings(); // Load training data on initial load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 180,
        flexibleSpace: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              child: Image.asset(
                'assets/my_training.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 10,
              top: 30,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return const HomeScreen();
                    }),
                  );
                },
                icon: const Icon(Icons.navigate_before_outlined,
                    color: Colors.black),
              ),
            ),
            Positioned(
              left: 70,
              top: 35,
              child: Text(
                'My Training',
                style: GoogleFonts.poppins(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: trainingList.length,
        itemBuilder: (context, index) {
          final training = trainingList[index];
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 7),
                    blurRadius: 8,
                    spreadRadius: 0,
                    color: Color.fromARGB(255, 237, 193, 245),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    training['title'],
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 3, bottom: 5),
                    child: Text(
                      training['description'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Training days: ${training['days']}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit_outlined, size: 20),
                            onPressed: () {
                              // Handle edit functionality here
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, size: 20),
                            onPressed: () {
                              _deleteTraining(training['id']);
                            },
                          ),
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


