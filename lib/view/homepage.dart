import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
              color: Color(0xffD7F0EE),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.notifications_none_outlined,
                      size: 30,
                      color: Colors.black54,
                    ),
                    Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.black54,
                    ),
                  ],
                ),
                SizedBox(height: 80),
                Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
                  child: Text(
                    "Sugeng rawuh dan sugeng hancok",
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      // Action when button is pressed
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text(
                      'Login or Register',
                      style: TextStyle(color: Color(0xFF037F74)), // set text color to the specified color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
