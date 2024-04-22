import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:booking/view/booking.dart';
import 'package:booking/view/profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _bottomNavCurrentIndex = 0;
  String _selectedDentist = "Choose a dentist";

  @override
  void initState() {
    super.initState();
    _bottomNavCurrentIndex = 0;
     // Set currentIndex menjadi 0 saat initState
  }

  
  // Method untuk menampilkan bottom sheet
  void _showDentistSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Markocop'),
                onTap: () {
                  // Tambahkan aksi ketika dentist dipilih
                  setState(() {
                    _selectedDentist =
                        'Markocop'; // Update nama dentist yang dipilih
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('sugeng'),
                onTap: () {
                  // Tambahkan aksi ketika dentist dipilih
                  setState(() {
                    _selectedDentist =
                        'sugeng'; // Update nama dentist yang dipilih
                  });
                  Navigator.pop(context);
                },
              ),
              // Tambahkan daftar dentist lainnya sesuai kebutuhan
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
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
                      Icons.account_circle,
                      size: 30,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  "Hello!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "Bowo",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/slide1.jpeg',
                  fit: BoxFit.cover,
                  width: screenWidth,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/slide2.jpeg',
                  fit: BoxFit.cover,
                  width: screenWidth,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/slide3.jpeg',
                  fit: BoxFit.cover,
                  width: screenWidth,
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Booking",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB6366D),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFD7F0EE),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 TextButton.icon(
                  onPressed: () {
                    _showDentistSelectionSheet(
                        context); // Panggil method bottom sheet
                  },
                  icon: Icon(
                    Icons.person_3_rounded,
                    color: Color(0xFF16A69A),
                  ),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _selectedDentist, // Tampilkan nama dentist yang dipilih
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.calendar_today,
                    color: Color(0xFF16A69A),
                  ),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.access_time_filled_sharp,
                    color: Color(0xFF16A69A), // Atur warna ikon di sini
                  ),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Time",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8), // Berikan jarak antara ikon dan teks
                    ],
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Colors.white, // Atur latar belakang putih di sini
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Action when date button is pressed
                  },
                  icon: Icon(
                    Icons.production_quantity_limits_outlined,
                    color: Color(0xFF16A69A), // Atur warna ikon di sini
                  ),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Promo",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8), // Berikan jarak antara ikon dan teks
                    ],
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Colors.white, // Atur latar belakang putih di sini
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                      height: 5,
                    ),
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
                    // Action when arrow button is pressed
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
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
              onPressed: () {
                // Action when button is pressed
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 237, 69, 142),
                side: BorderSide(
                  color: Color.fromARGB(255, 237, 69, 142),
                  width: 2,
                ),
              ),
              child: Text(
                'Show more promo',
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Booking()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profiles()),
            );
          }
        },
        currentIndex: _bottomNavCurrentIndex,
        selectedItemColor: Color(0xFF16A69A),
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home, color: Color(0xFF037F74)),
            icon: Icon(
              Icons.home,
              color: Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.assignment, color: Color(0xFF037F74)),
            icon: Icon(
              Icons.assignment,
              color: Colors.grey,
            ),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person,
              color: Color(0xFF037F74),
            ),
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

