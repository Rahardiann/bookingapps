import 'package:flutter/material.dart';
import 'package:booking/view/booking.dart';
import 'package:booking/view/home.dart';

class Barcode extends StatefulWidget {
  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Barcode> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Booking()),
        );
        break;
      default:
        break;
    }
  }

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
                primary: Colors.black,
              ),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
                  SizedBox(width: 5),
                  Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
                color: Colors.black,
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
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 1, vertical: 20),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            height: 320,
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/splash.png',
                              width: 150,
                              height: 80,
                              errorBuilder: (context, error, stackTrace) {
                                return Text('Image not found',
                                    style: TextStyle(color: Colors.red));
                              },
                            ),
                            Icon(Icons.qr_code_2, size: 130),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 2,
                      color: Color(0xFF037F74),
                      height: 210,
                      margin: EdgeInsets.symmetric(vertical: 5),
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
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Medical record | 001',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
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
                                    padding: EdgeInsets.all(4),
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
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF037F74),
                                    ),
                                    padding: EdgeInsets.all(4),
                                    child: Icon(Icons.phone,
                                        size: 12, color: Colors.white),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '+6281234567822',
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
                    width: double.infinity,
                    color: Color(0xFF037F74),
                  ),
                ),
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
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      border: Border(
                        right: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}