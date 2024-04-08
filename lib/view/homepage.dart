import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            // Tambahkan logika untuk menangani notifikasi di sini
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Tambahkan logika untuk menangani profil di sini
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xffD7F0EE),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            height: 100.0,
            width: double.infinity,
            margin: EdgeInsets.only(top: AppBar().preferredSize.height),
          ),
          Positioned.fill(
            bottom: 8.0, // Margin bawah 8.0 pada Container
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                  ),
                ),
                // Lakukan validasi login atau tindakan lain di sini
                // Misalnya, print pesan "Login berhasil" untuk menunjukkan tombol berfungsi
                onPressed: () {
                  // Tambahkan logika untuk tombol login di sini
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  child: Text(
                    "Login or Regrister",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF037F74)
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
