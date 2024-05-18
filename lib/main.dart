import 'package:booking/view/booking.dart';
import 'package:booking/view/notif/notificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:booking/widget/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presensi',
      debugShowCheckedModeBanner: false,
      // Tambahkan properti routes
      routes: {
        '/': (context) => Splashscreen(), // Rute beranda
        '/notifikasi': (context) => NotificationScreen(), // Rute notifikasi
        '/booking': (context) => Booking(), 
      },
      initialRoute: '/', // Rute awal ketika aplikasi dimulai
    );
  }
}
