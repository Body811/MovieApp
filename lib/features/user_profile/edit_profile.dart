import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:projectt/user_info.dart';

TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _dobController = TextEditingController();
DateTime? _selectedDate;
File? _image;
String? _selectedCountry;
bool _isPasswordVisible = false;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<String> countries = [
      'Australia',
      'Brazil',
      'Canada',
      'China',
      'Egypt' ,
      'France',
      'Iceland',
      'India',
      'Indonesia',
      'Iran',
      'Iraq',
      'Ireland',
      'Italy',
      'Japan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(top: 22),
            child: IconButton( // back button
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_rounded)),
          ),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, right: 85),
              child: Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: _image == null ? null : FileImage(_image!),
                    maxRadius: 80,
                  ),
                  GestureDetector(
                    onTap: _showImagePickerOptions,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 90),
                      child: Icon(Icons.camera_alt),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  buildTextField("Name", _nameController),
                  buildTextField("Email", _emailController, isEmail: true),
                  buildTextField("Password", _passwordController, isPassword: true),
                  Padding(
                    padding: const EdgeInsets.only(right: 220),
                    child: Text(
                      "Date Of Birth",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  buildDateField(),
                  Padding(
                    padding: const EdgeInsets.only(right: 175),
                    child: Text(
                      "Country/Region",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  buildCountryDropdown(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      onPressed: (){
                        String formattedDate = _selectedDate != null
                            ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                            : 'No date selected';
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserInfo(userName: _nameController.text, country: _selectedCountry! , data: formattedDate, image: _image,)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        child: Text(
                          "Save changes",
                          style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
    );
  }

  Padding buildTextField(String label, TextEditingController controller, {bool isEmail = false, bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: controller,
            inputFormatters: isEmail ? [FilteringTextInputFormatter.deny(RegExp(r'[\s]'))] : null,
            decoration: InputDecoration(
              labelText: "Enter your $label",
              border: OutlineInputBorder(),
              suffixIcon: isPassword
                  ? IconButton(
                icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
                  : null,
            ),
            obscureText: isPassword && !_isPasswordVisible,
            keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
          ),
        ],
      ),
    );
  }

  Padding buildDateField() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: TextField(
        controller: _dobController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        readOnly: true,
        onTap: () => _selectDate(context),
      ),
    );
  }

  Widget buildCountryDropdown() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DropdownButtonFormField<String>(
          value: _selectedCountry,
          decoration: InputDecoration(
            labelText: "Country/Region",
            border: OutlineInputBorder(),
          ),
          onChanged: (String? newValue) {
            setState(() {
              _selectedCountry = newValue;
            });
          },
          items: countries.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),

    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text("Take a photo"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Choose from gallery"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  void pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No image selected.')));
    }
  }

  void uploadUserDataToFirestore() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _dobController.text.isEmpty || _selectedCountry == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields.')));
      return;
    }

    // Validate email format
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid email.')));
      return;
    }

    // Check password length and strength
    if (_passwordController.text.length < 6 || !isPasswordStrong(_passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password must be at least 6 characters long and include uppercase, lowercase, and a number.')));
      return;
    }

    // Show loading indicator while uploading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    final userRef = FirebaseFirestore.instance.collection('users').doc();
    String? imageUrl;

    if (_image != null) {
      final storageRef = FirebaseStorage.instance.ref().child('user_images').child(userRef.id + '.jpg');
      await storageRef.putFile(_image!);
      imageUrl = await storageRef.getDownloadURL();
    }

    try {
      await userRef.set({
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'dob': _dobController.text,
        'country': _selectedCountry,
        'imageUrl': imageUrl,
      });
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully!')));
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
    }
  }

  bool isPasswordStrong(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

}
