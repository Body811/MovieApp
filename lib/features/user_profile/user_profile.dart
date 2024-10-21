import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'edit_profile.dart';

class UserProfile extends StatefulWidget {

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
    String userName = '';
    String? country;
    String? date;
    String? imageUrl;
    String? email;
    File? image;

    @override
    void initState() {
      super.initState();
       _getUserData();
    }

    Future<void> _getUserData() async {
      try {
        // Get the current Firebase user
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

          if (userData.exists) {
            setState(() {
              setState(() {
                userName = userData['username'];
                country = userData['country'];
                date = userData['dateOfBirth'];
                email = userData['email'];
                imageUrl = userData['profilePictureUrl'];
              });
            });
          }

          if (imageUrl != null) {
            String downloadURL = await FirebaseStorage.instance
                .ref(imageUrl)
                .getDownloadURL();
            setState(() {
              imageUrl = downloadURL;
            });
          }
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }

    Future<void> _logout() async {
      try {
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        print('Error signing out: $e');
      }
    }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
          padding: const EdgeInsets.only(top: 5,right: 15),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: IconButton( // log out
              onPressed: () {
                print("test");
                _logout();
              },
              icon: const Icon(Icons.logout_outlined, size: 42),
            ),
          ),
        ),]
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            maxRadius: 85,
            backgroundImage: imageUrl != null
                ? NetworkImage(imageUrl!)
                : null, // Load image from Firebase Storage URL
            child: imageUrl == null
                ? const Icon(Icons.person, size: 85) // Fallback icon if no image
                : null,
          ),
          const SizedBox(height: 30),

          Text(
            userName,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.indigo[900],
            ),
          ),
          SizedBox(height: 10,),
          Text(
            date ?? 'Not Found',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_pin,
                color: Colors.grey[700],
                size: 30,
              ),
              SizedBox(width: 3,),
              Text(
                country ?? 'Not Found',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
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
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              child: Text(
                "Edit Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
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
