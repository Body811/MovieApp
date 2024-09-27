import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projectt/edit_profile.dart';

class UserInfo extends StatelessWidget {
  final String userName;
  final String country;
  final String data ;
  final File? image;

  UserInfo({
    required this.userName,
    required this.country,
    required this.data,
     this.image
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10, left: 320),
          child: IconButton( // log out
            onPressed: () {
              Navigator.pop(context); // Close the UserInfo screen
            },
            icon: Icon(Icons.exit_to_app_sharp, size: 45),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            maxRadius: 85,
            backgroundImage: image != null ? FileImage(image!) : null,
            child: image == null
                ? Icon(Icons.person, size: 85) // Fallback icon if no image
                : null,
          ),
          SizedBox(height: 30),

          Text(
            userName,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[900],
            ),
          ),
          Text(
            data,
            style: TextStyle(
              fontSize: 25,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_pin,
                color: Colors.grey[700],
                size: 40,
              ),
              SizedBox(width: 5),
              Text(
                country,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          SizedBox(height: 300),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfile()), // Navigate to EditProfile
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 11),
              child: Text(
                "Edit Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
