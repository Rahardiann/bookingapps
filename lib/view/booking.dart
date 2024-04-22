import 'package:booking/view/home.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:booking/view/homepage.dart';
import 'package:booking/beforelogin/profilenone.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  int _bottomNavCurrentIndex = 1;
  String _selectedItem = 'Bowo'; //nama yang pertama harus sama dengan ini

  List<String> _items = [
    'Bowo',
    'Budi',
    'Sugeng',
    'Dian',
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                primary: Colors.black, // Mengatur warna teks tombol
              ),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios,
                      size: 20, color: Colors.black), // Mengatur warna ikon
                  SizedBox(width: 5),
                  Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Mengatur warna teks
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Booking',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Mengatur warna teks
              ),
            ),
            SizedBox(width: 90),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedItem,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue!;
                      });
                    },
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    elevation: 4,
                    icon: Icon(Icons.arrow_drop_down),
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    isExpanded: true,
                    dropdownColor: Colors.grey[200],
                    items: _items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2, top: 30),
                  child: Text(
                    'Congratulations',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2, top: 4, bottom: 8),
                  child: Text(
                    'Your scheduling data is confirmed',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _bottomNavCurrentIndex = index;
          });

          switch (index) {
            case 0:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
              break;
            case 1:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Booking()));
              break;
            case 2:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
              break;
          }
        },
        currentIndex: _bottomNavCurrentIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home, color: Color(0xFF037F74)),
            icon: Icon(Icons.home, color: Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.assignment, color: Color(0xFF037F74)),
            icon: Icon(Icons.assignment, color: Colors.grey),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person, color: Color(0xFF037F74)),
            icon: Icon(Icons.person, color: Colors.grey),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
