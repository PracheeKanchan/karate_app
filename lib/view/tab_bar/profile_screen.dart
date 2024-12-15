// lib/pages/profile_page.dart
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
  String? _imageUrl;
  File? _imageFile;

  Map<String, String> userProfile = {
    'username': 'John Doe',
    'email': 'johndoe@example.com',
    'mobile': '+91 9876543210',
    'dob': '01/01/2000',
    'address': '123 Main Street, City',
    
  };

  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    _imageUrl = 'https://xsgames.co/randomusers/avatar.php?g=male';
    userProfile.forEach((key, value) {
      controllers[key] = TextEditingController(text: value);
    });
  }

  @override
  void dispose() {
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
                      setState(() {
                        controllers.forEach((key, controller) {
                          userProfile[key] = controller.text;
                        });
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Profile Updated Successfully')),
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
                                : NetworkImage(_imageUrl!) as ImageProvider,
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
                        : NetworkImage(_imageUrl!) as ImageProvider,
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
                children: userProfile.entries.map((entry) {
                  IconData icon;
                  switch (entry.key) {
                    case 'username':
                      icon = Icons.person;
                      break;
                    case 'email':
                      icon = Icons.email;
                      break;
                    case 'mobile':
                      icon = Icons.phone;
                      break;
                    case 'dob':
                      icon = Icons.calendar_today;
                      break;
                    case 'address':
                      icon = Icons.location_on;
                      break;
                    default:
                      icon = Icons.info;
                  }
                  return _buildProfileField(
                    icon: icon,
                    label: entry.key.replaceAll('_', ' ').toUpperCase(),
                    value: entry.value,
                  );
                }).toList(),
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
