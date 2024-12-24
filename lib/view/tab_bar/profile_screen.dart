import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final ImagePicker _picker = ImagePicker();
   // Firebase Firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  String? _imageUrl;
  File? _imageFile;
  List<Map<String,dynamic>> profileInfoList=[];

  // Initialize controllers for user profile fields
  final Map<String, TextEditingController> controllers = {
    'username': TextEditingController(),
    'email': TextEditingController(),
    'mobile': TextEditingController(),
    'dob': TextEditingController(),
    'address': TextEditingController(),
  };

// for(int i=0;i<profileInfoList.length;i++){
//             if(SessionData.emailId == profileInfoList[i]['email']){
//               controllers['username']!.text=profileInfoList[i]['username']?? '';
//               controllers['email']!.text=profileInfoList[i]['email']?? '';
//               controllers['mobile']!.text=profileInfoList[i]['mobile']?? '';
//               controllers['dob']!.text=profileInfoList[i]['dob']?? '';
//               controllers['address']!.text=profileInfoList[i]['address']?? '';
//               _imageUrl=profileInfoList[i]['profile_image'] ?? _imageUrl;
//             }
//         }
  @override
  void initState() {
    super.initState();
    // Set default image URL or you could use a local path
    _imageUrl = 'https://xsgames.co/randomusers/avatar.php?g=male';
    _fetchUserData(); // Fetch user data when the widget is initialized

  }

// Fetch user data from Firestore
   Future<void> _fetchUserData() async {
    
    try {
      QuerySnapshot response = await firestore.collection("UsersProfile").get();
      setState(() {
        profileInfoList = response.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
        
        // If profile data is available, populate the controllers
        if (profileInfoList.isNotEmpty) {
          for(int i=0;i<profileInfoList.length;i++){
            var userData = profileInfoList[i]; // Assuming you're fetching only one profile
            controllers['username']!.text = userData['username'] ?? '';
            controllers['email']!.text = userData['email'] ?? '';
            controllers['mobile']!.text = userData['mobile'] ?? '';
            controllers['dob']!.text = userData['dob'] ?? '';
            controllers['address']!.text = userData['address'] ?? '';
            _imageUrl = userData['profile_image'] ?? _imageUrl; // Set profile image URL
          }
        }
      });
      log("$profileInfoList"); // Log the fetched data
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load profile data')),
      );
    }
  }


  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          
          _imageFile = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

// Save profile data to Firestore
  Future<void> saveProfileData() async {
    try {
      await firestore.collection('UsersProfile').add({
        'username': controllers['username']!.text,
        'email': controllers['email']!.text,
        'mobile': controllers['mobile']!.text,
        'dob': controllers['dob']!.text,
        'address': controllers['address']!.text,
        'profile_image': _imageFile != null ? _imageFile!.path : null,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Updated Successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save profile data')),
      );
    }
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                backgroundColor: Colors.blue.shade300,
                title: const Text('Edit Profile'),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      saveProfileData();  // Save the data to Firestore
                      setState(() {
                        // Save entered data
                        // You can save to a database or any other method
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile Updated Successfully')),
                      );
                    },
                    child: const Text(
                      'SAVE',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _imageFile != null
                                ? FileImage(_imageFile!)
                                : NetworkImage(_imageUrl!) ,
                          ),
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade300,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildDialogField(
                        controller: controllers['username']!,
                        label: 'Username',
                        icon: Icons.person,
                      ),
                      _buildDialogField(
                        controller: controllers['email']!,
                        label: 'Email',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      _buildDialogField(
                        controller: controllers['mobile']!,
                        label: 'Mobile Number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),
                      _buildDialogField(
                        controller: controllers['dob']!,
                        label: 'Date of Birth',
                        icon: Icons.calendar_today,
                        readOnly: true,
                        onTap: () async {
                          DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          controllers['dob']!.text =
                              "${date!.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
                        },
                      ),
                      _buildDialogField(
                        controller: controllers['address']!,
                        label: 'Address',
                        icon: Icons.location_on,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
    int? maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue.shade300),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade300),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        maxLines: maxLines,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _showEditProfileDialog,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : NetworkImage(_imageUrl!),
                    backgroundColor: Colors.grey[300],
                  ),
                  Positioned(
                    right: 140,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildProfileField(
                    icon: Icons.person,
                    label: 'Username',
                    value: controllers['username']!.text.isEmpty ? "" : controllers['username']!.text,
                  ),
                  _buildProfileField(
                    icon: Icons.email,
                    label: 'Email',
                    value: controllers['email']!.text.isEmpty ? "" : controllers['email']!.text,
                  ),
                  _buildProfileField(
                    icon: Icons.phone,
                    label: 'Mobile Number',
                    value: controllers['mobile']!.text.isEmpty ? "" : controllers['mobile']!.text,
                  ),
                  _buildProfileField(
                    icon: Icons.calendar_today,
                    label: 'Date of Birth',
                    value: controllers['dob']!.text.isEmpty ? "": controllers['dob']!.text,
                  ),
                  _buildProfileField(
                    icon: Icons.location_on,
                    label: 'Address',
                    value: controllers['address']!.text.isEmpty ? "" : controllers['address']!.text,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue.shade300),
        title: Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
