import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:booking/view/home.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:booking/view/homepage.dart';
import 'package:booking/beforelogin/profilenone.dart';
import 'package:booking/view/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Booking extends StatefulWidget {
  final BookingData? bookingData; // Ubah menjadi nullable (opsional)

  Booking({this.bookingData}); // Tandai sebagai opsional dengan '?'

  @override
  _BookingState createState() => _BookingState();
}

class HistoryData {
  final String nama_dokter;
  final String jadwal;
  final String jam;
  final String promo;

  HistoryData(
      {
      required this.nama_dokter,
      required this.jadwal,
      required this.jam,
      required this.promo});

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      nama_dokter: json['nama'],
      jadwal: json['jadwal'],
      jam: json['jam'],
      promo: json['judul'],
    );
  }
}

class _BookingState extends State<Booking> {
  int _bottomNavCurrentIndex = 1;
  String nama_dokter = "";
  DateTime jadwal = DateTime.now();
  String jam = "";
  String promo = "";
  String _selectedItem = 'Budi';
  String _selectedDentist = "";
  DateTime _selectedDate = DateTime.now();
  String _selectedTimeText = 'Select Time';
  String _selectedPromo = "Promo";
  String _username = "";
  int _selectedDentistId = 0;
  int _selectedPromoId = 0;
  int _selectedJadwalId = 0; //nama yang pertama harus sama dengan ini
  bool isLoading = false;
  List<HistoryData> history = [];
  
  List<String> _items = [
    'Bowo',
    'Budi',
    'Sugeng',
    'Dian',
  ];

  @override
  void initState() {
    super.initState();
    fetchBooking();
    fetchData();
  }

  Future<void> fetchBooking() async {
    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? id = prefs.getInt('id_booking');

      String apiUrl = "http://82.197.95.108:8003/booking/id/$id";
      Dio dio = Dio();
      Response response = await dio.get(apiUrl);
      print(response.data['data']);

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data['data'];
        // print(responseData);
        List<HistoryData> fetchedBooking =
            responseData.map((json) => HistoryData.fromJson(json)).toList();

        setState(() {
          history = fetchedBooking;
          isLoading = false;
        });
        // print("OK");
      } else {
        print("Error fetching dentists: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error bawah: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void fetchData() async {
    try {
      // Ambil email dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');

      if (email != null) {
        // Panggil API dengan menggunakan email sebagai parameter
        Response response =
            await Dio().get('http://82.197.95.108:8003/user/1/$email');

        // Periksa apakah respons sukses dan memiliki data
        if (response.statusCode == 200 && response.data['success']) {
          // Mengakses objek pertama dari list data
          Map<String, dynamic> userData = response.data['data'][0];
          String usernameFromData =
              userData['nama']; // Mengambil nama dari respons

          // Set username
          setState(() {
            _username = usernameFromData;
          });
        } else {
          // Handle respons yang tidak sesuai dengan harapan
          print('Error: ${response.data['message']}');
        }
      } else {
        // Handle jika email tidak tersedia di SharedPreferences
        print('Email tidak tersedia di SharedPreferences');
      }
    } catch (e) {
      // Handle kesalahan saat mengambil atau memproses data
      print('Error: $e');
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
              'Booking',
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
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedItem,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue!;
                      });
                    },
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    elevation: 4,
                    icon: Icon(Icons.arrow_drop_down),
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    isExpanded: true,
                    dropdownColor: Colors.grey[200],
                    items: _items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2, top: 30),
                  child: Text(
                    'Congratulations',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2, top: 4, bottom: 8),
                  child: Text(
                    'Your scheduling data is confirmed',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 2,
            color: Colors.grey[300],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 8.0),
                    child: Icon(Icons.account_circle, color: Colors.grey),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _username,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Medical record | 001',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '2 April, 9:45 AM',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Code booking',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Booking detail',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB6366D),
              ),
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
                SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person_3_rounded,
                    color: Color(0xFF16A69A),
                  ),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        history.isNotEmpty ? history[0].nama_dokter : '',
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
                        history.isNotEmpty ? history[0].jadwal.toString() : '',
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
                    color: Color(0xFF16A69A),
                  ),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        history.isNotEmpty ? history[0].jam : '',
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
                  onPressed: () {
                    // Action when date button is pressed
                  },
                  icon: Icon(
                    Icons.production_quantity_limits_outlined,
                    color: Color(0xFF16A69A),
                  ),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        history.isNotEmpty ? history[0].promo : '',
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
                SizedBox(height: 10),
              ],
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

          switch (index) {
            case 0:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
              break;
            case 1:
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Booking(bookingData: BookingData,)));
            // break;
            case 2:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profiles()));
              break;
          }
        },
        currentIndex: _bottomNavCurrentIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home, color: Color(0xFF037F74)),
            icon: Icon(Icons.home, color: Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.assignment, color: Color(0xFF037F74)),
            icon: Icon(Icons.assignment, color: Colors.grey),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person, color: Color(0xFF037F74)),
            icon: Icon(Icons.person, color: Colors.grey),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
