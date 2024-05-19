import 'package:booking/view/form/barcode.dart';
import 'package:booking/view/form/detailhistory.dart';
import 'package:booking/view/form/histori.dart';
import 'package:booking/view/form/user.dart';
import 'package:booking/view/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:booking/view/booking.dart';
import 'package:booking/view/home.dart';
import 'package:booking/view/form/editprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profiles extends StatefulWidget {
  @override
  _ProfilesState createState() => _ProfilesState();
}


class _ProfilesState extends State<Profiles> {
  int _selectedIndex = 2; // Set indeks sesuai dengan "Profile"
String _username = "";
int _rekam=0;

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
  void initState() {
    super.initState();
    fetchData();
  }
  void fetchData() async {
    try {
      // Ambil email dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');

      if (email != null) {
        // Panggil API dengan menggunakan email sebagai parameter
        Response response =
            await Dio().get('http://82.197.95.108:8003/user/1/$email');

        // Periksa apakah respons sukses dan memiliki data
        if (response.statusCode == 200 && response.data['success']) {
          // Mengakses objek pertama dari list data
          Map<String, dynamic> userData = response.data['data'][0];
          String usernameFromData =
              userData['nama']; 
               int rekamFromData =
              userData['no_rekam_medis'];// Mengambil nama dari respons

          // Set username
          setState(() {
            _username = usernameFromData;
            _rekam = rekamFromData;
          });
        } else {
          // Handle respons yang tidak sesuai dengan harapan
          print('Error: ${response.data['message']}');
        }
      } else {
        // Handle jika email tidak tersedia di SharedPreferences
        print('Email tidak tersedia di SharedPreferences');
      }
    } catch (e) {
      // Handle kesalahan saat mengambil atau memproses data
      print('Error: $e');
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
              'Profile',
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
                      _username, // Ganti dengan nama pengguna yang sesuai
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Medical record | ${_rekam}', // Sub judul
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
          TextButton(
            onPressed: () {
              // Tambahkan logika untuk tindakan saat container ditekan
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD7F0EE),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 20.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: Icon(
                        Icons.card_membership,
                        color: Color(0xFF16A69A),
                        size: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Membership',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.black,
                              ),
                              onPressed: () {
                                // Tambahkan logika untuk tindakan saat tombol ditekan
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      
        TextButton(
             onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Barcode()), // Sesuaikan dengan route halaman Edit Profile
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD7F0EE),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(
                  horizontal: 10,), // Hapus jarak vertikal di sini
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 20.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: Icon(
                        Icons.qr_code_2,
                        color: Color(0xFF16A69A),
                        size: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Show QR profile',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios,
                                  size: 15, color: Colors.black),
                              onPressed: () {
                                // Tambahkan logika untuk tindakan saat tombol ditekan
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        TextButton(
            onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditProfile()), // Sesuaikan dengan route halaman Edit Profile
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD7F0EE),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(
                horizontal: 10,
              ), // Hapus jarak vertikal di sini
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 20.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF16A69A),
                        size: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Detail profile',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios,
                                  size: 15, color: Colors.black),
                              onPressed: () {
                                // Tambahkan logika untuk navigasi ke halaman Edit Profile
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfile()), // Sesuaikan dengan route halaman Edit Profile
                                );
                              },
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          TextButton(
            onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailHistory()), // Sesuaikan dengan route halaman Edit Profile
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD7F0EE),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(
                horizontal: 10,
              ), // Hapus jarak vertikal di sini
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 20.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: Icon(
                        Icons.history_edu,
                        color: Color(0xFF16A69A),
                        size: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Visit history',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios,
                                  size: 15, color: Colors.black),
                              onPressed: () {
                                // Tambahkan logika untuk tindakan saat tombol ditekan
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),


          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Userprofile()), // Sesuaikan dengan route halaman Edit Profile
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD7F0EE),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(
                horizontal: 10,
              ), // Hapus jarak vertikal di sini
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 20.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: Icon(
                        Icons.people_sharp,
                        color: Color(0xFF16A69A),
                        size: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'User',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios,
                                  size: 15, color: Colors.black),
                              onPressed: () {
                                // Tambahkan logika untuk tindakan saat tombol ditekan
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
             
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red[600],
                // Border berwarna biru
              ),
              child: Text(
                'logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF16A69A),
        onTap: _onItemTapped,
      ),
    );
  }
}
