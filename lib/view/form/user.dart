import 'package:flutter/material.dart';
import 'package:booking/view/login.dart';
import 'package:booking/view/booking.dart';
import 'package:booking/view/home.dart';
import 'package:booking/view/form/editprofile.dart';

class User extends StatefulWidget {
  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<User> {
  int _selectedIndex = 2; // Set indeks sesuai dengan "Profile"

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Tambahkan logika navigasi di sini sesuai dengan masing-masing index
    switch (index) {
      case 0:
        // Navigasi ke halaman Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        break;
      case 1:
        // Navigasi ke halaman Booking
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Booking()),
        );
        break;
      default:
        // Tidak perlu navigasi untuk halaman Profile
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil lebar layar
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
              'User',
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
            decoration: BoxDecoration(
              color: Color(0xFFD7F0EE),
              borderRadius:
                  BorderRadius.circular(15), // Tambahkan border radius di sini
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 5.0,
                      right: 8.0), // Margin di sebelah kiri ikon profil
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Budi', // Ganti dengan nama pengguna yang sesuai
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Medical record | 001', // Sub judul
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFD7F0EE),
              borderRadius:
                  BorderRadius.circular(15), // Tambahkan border radius di sini
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 5.0,
                      right: 8.0), // Margin di sebelah kiri ikon profil
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BOWO', // Ganti dengan nama pengguna yang sesuai
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Medical record | 001', // Sub judul
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
          onPressed: () {
           Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EditProfile()), // Sesuaikan dengan route halaman Edit Profile
            );
          },
          label: Text(
            'Add User',
            style: TextStyle(
                color: Colors.white), // Mengatur warna teks menjadi putih
          ),
          extendedPadding: EdgeInsets.symmetric(horizontal: 80),
          backgroundColor: Color(0xFF16A69A), // Warna latar belakang tombol
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
