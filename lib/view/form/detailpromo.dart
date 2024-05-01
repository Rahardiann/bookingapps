import 'dart:io';
import 'package:booking/view/home.dart';
import 'package:flutter/material.dart';

class Detailpromo extends StatefulWidget {
  @override
  _DetailpromoState createState() => _DetailpromoState();
}

class _DetailpromoState extends State<Detailpromo> {
  int _bottomNavCurrentIndex = 1;

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

                  Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Mengatur warna teks
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Text(
              'Promo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Mengatur warna teks
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.account_circle,
              size: 30,
              color: Colors.black54,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
                  child: Image.asset(
                    'assets/slide2.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'New Patient Discount',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Sarlita Dental Care',
                style: TextStyle(fontSize: 16, color: Colors.black38),
              ),
              SizedBox(height: 30),
              Text(
                'Welcome to Sarlita Dental Care! As an expression of gratitude for your trust, we are very happy to provide special promotions to our new patients. With this promo, you will enjoy high-quality dental health services at special prices.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 20),
              Text(
                'Term and conditions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                  height:
                      10), // Add some spacing between the title and the terms
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. ',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  Expanded(
                    child: Text(
                      'This discount is only valid for new customers who have never visited our clinic before.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2. ',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  Expanded(
                    child: Text(
                      'To avail of this discount, you need to mention or present the promotional code provided at the time of booking or your first visit.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3. ',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  Expanded(
                    child: Text(
                      'This discount is only valid for a certain period. Make sure to claim it before the deadline expires.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '4. ',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  Expanded(
                    child: Text(
                      'This discount cannot be combined with any other offers or promotions currently running at our clinic.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Additional Information', // Add your title here
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We reserve the right to change or delete these terms and conditions without prior notice. This discount cannot be exchanged for cash and is not transferable.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 20),
              // Add your Booking Now button here
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Home()), // Ganti Home() dengan tampilan beranda Anda
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 72),
                      backgroundColor: Color(
                          0xFFE65895), // Adjust the vertical padding as needed
                    ),
                    child: Text(
                      'Booking',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
