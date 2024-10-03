import 'dart:io';
import 'package:flutter/material.dart';

import 'edit_profile.dart';

class UserProfile extends StatelessWidget {
  final String userName;
  final String? country;
  final String? date ;
  final File? image;

  UserProfile({
    required this.userName,
     this.country,
     this.date,
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
              Navigator.pop(context); // Close the UserProfile screen
            },
            icon: const Icon(Icons.exit_to_app_sharp, size: 45),
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
                ? const Icon(Icons.person, size: 85) // Fallback icon if no image
                : null,
          ),
          const SizedBox(height: 30),

          Text(
            userName,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[900],
            ),
          ),
          Text(
            date!,
            style: const TextStyle(
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
              const SizedBox(width: 5),
              Text(
                country!,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 300),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfile()), // Navigate to EditProfile
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 11),
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
