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
 String _selectedItem = 'Item 1'; // Inisialisasi _selectedItem


  List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[200], // Warna latar belakang abu-abu
              borderRadius: BorderRadius.circular(20), // Radius sudut 20px
            ),
            child: Center(
              child: DropdownButton<String>(
                value: _selectedItem,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedItem = newValue!;
                  });
                },
                style: TextStyle(
                  fontSize: 16, // ukuran teks dropdown
                  color: Colors.black, // warna teks dropdown
                ),
                elevation: 4, // elevasi dropdown
                icon: Icon(Icons.arrow_drop_down), // ikon dropdown
                underline: Container(
                  // garis bawah dropdown
                  height: 2,
                  color: Colors.transparent, // membuat garis bawah transparan
                ),
                isExpanded: true, // membuat dropdown memenuhi lebar container
                dropdownColor:
                    Colors.grey[200], // warna latar belakang dropdown
                items: _items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      width: double
                          .infinity, // membuat teks dropdown memenuhi lebar dropdown
                      child: Text(value),
                    ),
                  );
                }).toList(),
              ),
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
