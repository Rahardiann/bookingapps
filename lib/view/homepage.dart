import 'package:booking/beforelogin/booknone.dart';
import 'package:booking/beforelogin/profilenone.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:booking/view/login.dart'; // Update import

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Mengambil lebar layar
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
              color: Color(0xffD7F0EE),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.notifications_none_outlined,
                      size: 30,
                      color: Colors.black54,
                    ),
                    Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.black54,
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
                  child: Text(
                    "Bergabung dan nikmati keuntungan menjadi anggota kami",
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      // Aksi ketika tombol ditekan
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text(
                      'Login or Regrister',
                      style: TextStyle(color: Color(0xFF037F74)),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Tambahkan spasi sebelum carousel
              ],
            ),
          ),
          SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: [
              // Contoh gambar slide
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/slide1.jpeg',
                  fit: BoxFit.cover,
                  width: screenWidth, // Set lebar gambar menjadi lebar layar
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/slide2.jpeg',
                  fit: BoxFit.cover,
                  width: screenWidth, // Set lebar gambar menjadi lebar layar
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/slide3.jpeg',
                  fit: BoxFit.cover,
                  width: screenWidth, // Set lebar gambar menjadi lebar layar
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          // Judul dan subjudul
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Promo",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB6366D),
                      ),
                    ),
                    SizedBox(
                        height: 5), // Tambahkan spasi antara judul dan subjudul
                    Text(
                      "Find attractive offers in our promotions",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: () {
                    // Aksi ketika tombol panah diklik
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          'assets/slide2.jpeg',
                          width: screenWidth * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Routine check-up discounts',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          'assets/slide3.jpeg',
                          width: screenWidth * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'New patient discount',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol ditekan
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 237, 69, 142),
                side: BorderSide(
                    color: Color.fromARGB(255, 237, 69, 142), width: 2),
              ),
              child: Text(
                'Show More Promo',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _bottomNavCurrentIndex = index;
          });
          if (index == 1) {
            // Jika indeks adalah 1 (Booking), navigasi ke halaman Book()
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Book()),
            );
          } else if (index == 2) {
            // Jika indeks adalah 2 (Profile), navigasi ke halaman ProfilePage()
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          }
        },
        currentIndex: _bottomNavCurrentIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Color(0xFF037F74)
            ),
            icon: Icon(
              Icons.home,
              color: Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.assignment,
              color: Color(0xFF037F74)
            ),
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
