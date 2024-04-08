import 'package:flutter/material.dart';
import 'package:booking/widget/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Presensi',
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
