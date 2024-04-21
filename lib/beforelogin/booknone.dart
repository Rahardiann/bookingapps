import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:booking/view/homepage.dart';
import 'package:booking/beforelogin/profilenone.dart';

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  int _bottomNavCurrentIndex =
      1; // Set nilai awal ke 1 untuk menunjukkan halaman Booking

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
            child: Column(
              children: [
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Tombol Kembali
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // Teks Kembali
                    Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _bottomNavCurrentIndex = index;
          });

          // Menggunakan Navigator.push untuk navigasi
          switch (index) {
            case 0:
              // Jika indeks adalah 0 (Home), navigasi ke halaman HomePage
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
              break;
            case 1:
              // Jika indeks adalah 1 (Booking), navigasi ke halaman Book
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Book()));
              break;
            case 2:
              // Jika indeks adalah 2 (Profile), navigasi ke halaman Profile
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
              break;
          }
        },
        currentIndex: _bottomNavCurrentIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home, color: Color(0xFF037F74)),
            icon: Icon(
              Icons.home,
              color: Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.assignment, color: Color(0xFF037F74)),
            icon: Icon(
              Icons.assignment,
              color: Colors.grey,
            ),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.people,
              color: Color(0xFF037F74),
            ),
            icon: Icon(
              Icons.people,
              color: Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
