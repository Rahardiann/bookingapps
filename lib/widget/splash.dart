import 'dart:async';

import 'package:flutter/material.dart';
import 'package:booking/view/homepage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    // Setelah 3 detik, pindah ke layar berikutnya
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        // Gantilah "LoginScreen()" dengan layar yang ingin Anda tampilkan setelah splash screen
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white.withOpacity(0.8), // Mengatur warna latar belakang menjadi biru
        child: Stack(
          children: [
            // Logo dan Text "Attendance Management System"
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset('assets/splash.png'),
                ],
              ),
            ),

            // Positioned untuk menempatkan "powered by Sujiwo tejo" di paling bawah
            Positioned(
              left: 0,
              right: 0,
              bottom: 16, // Sesuaikan dengan jarak dari bawah yang diinginkan
              child: Center(
                child: Text(
                  "powered by Sujiwo tejo",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.8),
                    // Gunakan warna putih dengan opasitas rendah untuk watermark
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
