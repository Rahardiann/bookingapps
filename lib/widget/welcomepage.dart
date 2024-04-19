import 'dart:async';
import 'package:booking/view/home.dart';
import 'package:flutter/material.dart';
import 'package:booking/view/homepage.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({Key? key}) : super(key: key);

  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white.withOpacity(0.8), // Adjust the background color
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Image and Text "Attendance Management System"
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Congratulations Text
                Text(
                  "Congratulations!",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 120), // Add some space between title and image
                // Image
                Image.asset('assets/splash.png'),
                SizedBox(
                    height:
                        20), // Add some space between image and button/caption
                // Text "Your account has been registered"
                Text(
                  "Your account has been registered,",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "please enjoy our best features",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                 SizedBox(height: 90),
              ],
            ),

            // Positioned to place "powered by Sujiwo tejo" at the bottom
            Positioned(
              bottom: 16, // Adjust the distance from the bottom as desired
              child: Text(
                "powered by Sujiwo tejo",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),

            // Login Button
            Positioned(
              bottom: 100, // Adjust the distance from the bottom as desired
              child: SizedBox(
                width: 300, // Set the width of the button
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF16A69A), // Set button color
                  ),
                  child: Text(
                    "Get started",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
