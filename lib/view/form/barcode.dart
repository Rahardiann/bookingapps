import 'package:booking/view/login.dart';
import 'package:flutter/material.dart';
import 'package:booking/view/booking.dart';
import 'package:booking/view/home.dart';
import 'package:booking/view/form/editprofile.dart';

class Barcode extends StatefulWidget {
  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Barcode> {
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
              'Card',
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
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFD7F0EE),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), // Sudut kiri atas tetap bulat
                bottomLeft: Radius.circular(15), // Sudut kiri bawah tetap bulat
                topRight: Radius.circular(15), // Sudut kanan atas tetap bulat
                bottomRight:
                    Radius.circular(15), // Sudut kanan bawah tetap bulat
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 1, vertical: 20),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            height: 320,
            child: Stack(
              children: [
                // Garis horizontal di bagian atas kontainer
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stack untuk menempatkan gambar di atas ikon QR
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Image.asset(
                                'assets/splash.png',
                                width: 150,
                                height: 80,
                              ),
                            ),
                            Icon(Icons.qr_code_2, size: 130),
                            // Gambar di atas ikon QR
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 10), // Spasi antara gambar dan teks
                    // Stack untuk menempatkan teks

                    Container(
                      width: 2, // Lebar garis
                      color: Color(0xFF037F74), // Warna garis
                      height: 210, // Sesuaikan tinggi dengan ikon QR
                      margin: EdgeInsets.symmetric(
                        vertical: 5,
                      ), // Sesuaikan jarak dari atas dan bawah
                    ),

                    SizedBox(width: 10),
                    Expanded(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jacob More',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  height:
                                      5), // Spasi antara teks utama dan subjudul
                              Text(
                                'Medical record | 001',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 50),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF037F74),
                                    ),
                                    padding: EdgeInsets.all(
                                      4,
                                    ), // Atur ukuran padding sesuai kebutuhan
                                    child: Icon(Icons.location_on,
                                        size: 12, color: Colors.white),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      'Jl S Supriadi Gg 7 No 88228 Pangkalan Sudirman Blok 888 no 443',
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      10), // Spasi antara alamat dan nomor telepon
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF037F74),
                                    ),
                                    padding: EdgeInsets.all(
                                      4,
                                    ), // Atur ukuran padding sesuai kebutuhan
                                    child: Icon(Icons.phone,
                                        size: 12, color: Colors.white),
                                  ),
                                  SizedBox(width: 5), // Icon telepon
                                  // Spasi antara icon dan teks nomor telepon
                                  Text(
                                    '+6281234567822', // Ganti dengan nomor telepon Anda
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                Positioned(
                  top: 240,
                  left: 100,
                  right: 0,
                  child: Container(
                    height: 20,
                    width: double.infinity, // Mengisi lebar kontainer
                    color: Color(0xFF037F74),
                    // Warna garis
                  ),
                ),


                // Garis horizontal di bagian bawah kontainer
              Positioned(
                  top: 230,
                  left: 0,
                  right: 200,
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 219, 92, 147),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20), // Sudut kanan atas
                        bottomRight: Radius.circular(20), // Sudut kanan bawah
                      ),
                      border: Border(
                        right: BorderSide(
                          color: Colors.white, // Warna border putih
                          width: 2, // Lebar border
                        ),
                      ),
                    ),
                  ),
                ),

                 
              ],
            ),
            
          )

        ],
      ),
    );
  }
}
