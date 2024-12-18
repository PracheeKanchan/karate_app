import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/tab_bar/home_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as newPath;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Database initialization
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('reminders.db');
    return _database!;
  }

  // Open the database
  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final dbLocation = newPath.join(dbPath, path);
    return openDatabase(dbLocation, version: 1, onCreate: _onCreate);
  }

  // Create the table for reminders
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE reminders(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        time TEXT
      )
    ''');
  }

  // Insert a reminder
  Future<int> insertReminder(Map<String, dynamic> reminder) async {
    final db = await database;
    return await db.insert('reminders', reminder);
  }

  // Get all reminders
  Future<List<Map<String, dynamic>>> getReminders() async {
    final db = await database;
    return await db.query('reminders');
  }

  // Update a reminder
  Future<int> updateReminder(Map<String, dynamic> reminder) async {
    final db = await database;
    return await db.update(
      'reminders',
      reminder,
      where: 'id = ?',
      whereArgs: [reminder['id']],
    );
  }

  // Delete a reminder
  Future<int> deleteReminder(int id) async {
    final db = await database;
    return await db.delete(
      'reminders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}


class MyReminderScreen extends StatefulWidget {
  const MyReminderScreen({super.key});

  @override
  State createState() => _MyReminderScreen();
}

class _MyReminderScreen extends State<MyReminderScreen> {
  
  List<Map<String, dynamic>> reminderList = [];

  // Controller for TextField inputs in the dialog
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  TimeOfDay selectedTime = const TimeOfDay(hour: 12, minute: 0); // Default time is 12:00 PM

  @override
  void initState() {
    super.initState();
    _loadReminders(); // Load reminders from the database
  }

  // Method to load reminders from the database
  void _loadReminders() async {
    final reminders = await DatabaseHelper.instance.getReminders();
    setState(() {
      reminderList = reminders;
    });
  }

  // Method to show time picker dialog
  void _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
        timeController.text = selectedTime.format(context);
      });
    }
  }

  // Method to show dialog to add or edit reminder
  void _showAddEditReminderDialog({Map<String, dynamic>? reminder, int? index}) {
  // If it's an edit, load the existing data into the controllers
  if (reminder != null) {
    titleController.text = reminder['title'];
    timeController.text = reminder['time'];
  } else {
    // Clear the controllers if it's a new reminder
    titleController.clear();
    timeController.clear();
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(index == null ? 'Add Reminder' : 'Edit Reminder'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: 'Reminder Time',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () {
                  _selectTime(context); // Open time picker when tapped
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty && timeController.text.isNotEmpty) {
                final reminder = {
                  'title': titleController.text,
                  'time': timeController.text,
                };

                if (index == null) {
                  // Add new reminder
                  await DatabaseHelper.instance.insertReminder(reminder);
                } else {
                  // Edit existing reminder
                  reminder['id'] = reminderList[index]['id']; // Add ID for update
                  await DatabaseHelper.instance.updateReminder(reminder);
                }

                Navigator.pop(context); // Close the dialog
                _loadReminders(); // Reload reminders from the database

                // Clear the controllers after operation
                titleController.clear();
                timeController.clear();
              }
            },
            child: Text(index == null ? 'Add' : 'Update'),
          ),
        ],
      );
    },
  );
}


  // Delete a reminder by index
  void _deleteReminder(int index) async {
    final id = reminderList[index]['id'];
    await DatabaseHelper.instance.deleteReminder(id);
    _loadReminders(); // Reload reminders from the database
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
                'assets/reminder.jpg', // Replace with your image
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
                    color: Colors.white),
              ),
            ),
            Positioned(
              left: 70,
              top: 35,
              child: Text(
                'Reminder',
                style: GoogleFonts.poppins(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false, // Prevents default back button
      ),
      body: ListView.builder(
        itemCount: reminderList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final reminder = reminderList[index];
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
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
                    reminder['title'],
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 3, bottom: 5),
                    child: Text(
                      'Reminder Time: ${reminder['time']}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, size: 20),
                        onPressed: () {
                          _showAddEditReminderDialog(reminder: reminder, index: index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, size: 20),
                        onPressed: () {
                          _deleteReminder(index);
                        },
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
        onPressed: () {
          _showAddEditReminderDialog(); // Open dialog to add new reminder
        },
        tooltip: 'Add Reminder',
        child: const Icon(Icons.add),
      ),
    );
  }
}
