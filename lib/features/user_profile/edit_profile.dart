import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:movie_app/features/user_profile/user_profile.dart';
import 'package:movie_app/utils/validation_utils.dart';

import '../../core/widget/navbar.dart';
import '../Movies/presentation/pages/MainScreen_page.dart';


TextEditingController _nameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _dobController = TextEditingController();
DateTime? _selectedDate;
File? _image;
String? _selectedCountry;
bool _isPasswordVisible = false;

class EditProfile extends StatefulWidget {
  final String? userName;
  final String? dateOfBirth;
  final String? country;
  final String? profilePictureUrl;
  final String? email;

  const EditProfile({
    super.key,
    this.userName,
    this.dateOfBirth,
    this.country,
    this.profilePictureUrl,
    this.email
  });
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
  void initState() {
    super.initState();
    _nameController.text = widget.userName??'';
    _passwordController.text = '';
    _dobController.text = widget.dateOfBirth??'';
    _selectedCountry = widget.country;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, right: 85),
              child: Text(
                "Edit Profile",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    backgroundImage:_image != null
                        ? FileImage(_image!)
                        : (widget.profilePictureUrl != null
                        ? NetworkImage(widget.profilePictureUrl!)
                        : null),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  buildTextField("Name", _nameController),
                  SizedBox(height: 10,),

                  SizedBox(height: 10,),
                  buildTextField("Password", _passwordController, isPassword: true),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Date Of Birth",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  buildDateField(),
                  SizedBox(height: 10,),
                  Padding(

                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Country/Region",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  buildCountryDropdown(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: (){
                          String formattedDate = _selectedDate != null
                              ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                              : 'No date selected';
                              uploadUserDataToFirestore();
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
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
    );
  }

  Padding buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Enter your $label",
              hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
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
          hintText: 'Enter Date of Birth',
          hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
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
            hintText: "Country/Region",
            hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
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
    if (_nameController.text.isEmpty || _dobController.text.isEmpty || _selectedCountry == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields.')));
      return;
    }

    // Check password length and strength
    String? passwordErrorMessage = ValidationUtils.validatePassword(_passwordController.text);
    if(passwordErrorMessage != null ){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(passwordErrorMessage)));
      return;
    }

    // Show loading indicator while uploading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    User? user = FirebaseAuth.instance.currentUser;
    final userRef = FirebaseFirestore.instance.collection('users').doc(user?.uid);
    String? imageUrl;

    try {

      if (_image != null) {
        final storageRef = FirebaseStorage.instance.ref().child('user_images').child(userRef.id + '.jpg');
        await storageRef.putFile(_image!);
        imageUrl = await storageRef.getDownloadURL();
      }else{
        imageUrl = widget.profilePictureUrl;
      }
      await userRef.set({
        'username': _nameController.text,
        'dateOfBirth': _dobController.text,
        'country': _selectedCountry,
        'profilePictureUrl': imageUrl,
        'email': widget.email
      });
      await user!.updatePassword(_passwordController.text);
      Navigator.pop(context); // Close loading dialog
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully!',),duration: Duration(seconds: 10),));
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating profile: $e'),duration: Duration(seconds: 10)));
    }
  }
}
