import 'package:booking/view/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:booking/view/booking.dart';
import 'package:booking/view/home.dart';
import 'package:booking/view/form/editprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailHistory extends StatefulWidget {
  @override
  _DetailHistoryState createState() => _DetailHistoryState();
}

class VisitData {
  final String nama_dokter;
  final String nama_user;
  final String jadwal;
  final String jam;
  final String promo;

  VisitData({
    required this.nama_dokter,
    required this.nama_user,
    required this.jadwal,
    required this.jam,
    required this.promo,
  });

  factory VisitData.fromJson(Map<String, dynamic> json) {
    return VisitData(
      nama_dokter: json['dokter']['nama'],
      nama_user: json['user']['nama'],
      jadwal: json['jadwal']['jadwal'],
      jam: json['jadwal']['jam'],
      promo: json['promo']['judul'],
    );
  }
}

class _DetailHistoryState extends State<DetailHistory> {
  int _selectedIndex = 2; // Set indeks sesuai dengan "Profile"

  List<VisitData> visit = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchVisit();
  }

  Future<void> fetchVisit() async {
    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? id = prefs.getInt('id_user');

      String apiUrl = "http://82.197.95.108:8003/booking/$id";
      Dio dio = Dio();
      Response response = await dio.get(apiUrl);
      print(response.data['data']);
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data['data'];
        List<VisitData> fetchedVisit =
            responseData.map((json) => VisitData.fromJson(json)).toList();

        setState(() {
          visit = fetchedVisit;
          isLoading = false;
        });
      } else {
        print("Error fetching data: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

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
              'Visit History',
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
      body: ListView.builder(
        itemCount: visit.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0xFFD7F0EE),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Color(0xFF16A69A)),
                      SizedBox(width: 8),
                      Text(
                        ' ${visit[index].nama_user}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Color(0xFF16A69A)),
                      SizedBox(width: 8),
                      Text(
                        ' ${visit[index].nama_dokter}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Color(0xFF16A69A)),
                      SizedBox(width: 8),
                      Text(
                        ' ${visit[index].jadwal}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: Color(0xFF16A69A)),
                      SizedBox(width: 8),
                      Text(
                        '${visit[index].jam}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.local_offer, color: Color(0xFF16A69A)),
                      SizedBox(width: 8),
                      Text(
                        '${visit[index].promo}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
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
