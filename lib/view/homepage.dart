import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right:15, bottom: 10),
            decoration: BoxDecoration(
              color: Color(0xffD7F0EE),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.notifications_none_outlined,
                    size: 30,
                    color: Colors.black54
                  ),
                   Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.black54
                  ),
                ],
              ),
              SizedBox(height: 80,),
              Padding(
              padding: EdgeInsets.only(left:3, bottom: 15),
              child: Text("Sugeng rawuh dan sugeng hancok",
              style: TextStyle(
                fontSize: 11
              ),
              ),
              )
             ],
            ),
          ),
        ],
      ),
    );
  }
}
