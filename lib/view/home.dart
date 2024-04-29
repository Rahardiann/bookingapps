
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:booking/view/booking.dart';
import 'package:booking/view/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart'; 
import 'package:shared_preferences/shared_preferences.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _bottomNavCurrentIndex = 0;
  String _selectedDentist = "Choose a dentist";
   DateTime _selectedDate = DateTime.now();
   String _selectedTimeText = 'Select Time';
   String _selectedPromo = "Promo";
   String _username = "";


  @override
  void initState() {
    super.initState();
    _bottomNavCurrentIndex = 0;
    fetchData();
  }
  
void fetchData() async {
    try {
      // Ambil email dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');

      if (email != null) {
        // Panggil API dengan menggunakan email sebagai parameter
        Response response =
            await Dio().get('http://82.197.95.108:8003/user/$email');

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


  // Method untuk menampilkan bottom sheet
  void _showDentistSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
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
                
                
              ],
            ),
           
          ),
          body: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 5.0,
                            right: 20.0), // Margin di sebelah kiri ikon profil
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Markocop', // Ganti dengan nama pengguna yang sesuai
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Medical record | 001', // Sub judul
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                  
                  onTap: () {
                    // Tambahkan aksi ketika dentist dipilih
                    setState(() {
                      _selectedDentist = 'Markocop';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 5.0,
                            right: 20.0), // Margin di sebelah kiri ikon profil
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sugeng', // Ganti dengan nama pengguna yang sesuai
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Medical record | 001', // Sub judul
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    // Tambahkan aksi ketika dentist dipilih
                    setState(() {
                      _selectedDentist = 'sugeng';
                    });
                    Navigator.pop(context);
                  },
                ),
                // Tambahkan daftar dentist lainnya sesuai kebutuhan
              ],
            ),
          ),
        );
      },
    );
  }

 void _showDatePickerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Tidak perlu mengubah _selectedDate di sini
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                           color: Color(0xFFB6366D), 
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate,
                  onDateTimeChanged: (DateTime newDateTime) {
                    // Tambahkan logika di sini untuk menyimpan tanggal yang dipilih
                    setState(() {
                      _selectedDate = newDateTime;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

void _handleTimeSelection(String selectedTime) {
    setState(() {
      _selectedTimeText = selectedTime; // Perbarui nilai waktu yang dipilih
    });
  }


void _showTimePickerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
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
                          Icon(Icons.arrow_back_ios,
                              size: 20, color: Colors.black),
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
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                height: 200, // Sesuaikan dengan tinggi maksimum yang diinginkan
                child: ListView.builder(
                  itemCount: 17, // Misalnya, tampilkan 10 item
                  itemBuilder: (context, index) {
                    final time =
                        (index + 8).toString().padLeft(2, '0') + ' : 00';
                    return ListTile(
                      title: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFD7F0EE),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          time,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _handleTimeSelection(time);
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

void _showPromoSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Promo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios,
                            size: 20, color: Colors.black),
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
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedPromo = 'New patient discount';
                      });
                      Navigator.pop(context);
                      // Tambahkan logika untuk tindakan saat container ditekan
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFD7F0EE),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'New patient discount',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selectedPromo =
                                              'New patient discount';
                                        });
                                        Navigator.pop(context);
                                        // Tambahkan logika untuk tindakan saat tombol ditekan
                                      },
                                    ),
                                  ],
                                ),
                                // Tambahkan jarak vertikal antara judul dan deskripsi
                                Text(
                                  'Get high quality dental filling treatment at special prices.',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedPromo = 'Routine check-up discounts';
                      });
                      Navigator.pop(context);
                      // Tambahkan logika untuk tindakan saat container ditekan
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFD7F0EE),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Routine check-up discounts',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selectedPromo =
                                              'Routine check-up discounts';
                                        });
                                        Navigator.pop(context);
                                        // Tambahkan logika untuk tindakan saat tombol ditekan
                                      },
                                    ),
                                  ],
                                ),
                                // Tambahkan jarak vertikal antara judul dan deskripsi
                                Text(
                                  'Get high quality dental filling treatment at special prices.',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  
                  // Tambahkan daftar promo lainnya sesuai kebutuhan
                ],
              ),
            ),
          ],
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
                  _username,
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
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                  onPressed: () {
                    _showDatePickerSheet(context);
                  },
                  icon: Icon(
                    Icons.calendar_today,
                    color: Color(0xFF16A69A),
                  ),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        // Tampilkan tanggal yang dipilih, atau 'Date' jika belum dipilih
                        _selectedDate != null
                            ? "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"
                            : 'Date',
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
                    _showTimePickerSheet(context);
                  },
                  icon: Icon(
                    Icons.access_time_filled_sharp,
                    color: Color(0xFF16A69A),
                  ),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _selectedTimeText, // Tampilkan waktu yang dipilih
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
                    _showPromoSelectionSheet(context);
                  },
                  icon: Icon(
                    Icons.local_offer,
                    color: Color(0xFF16A69A),
                  ),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _selectedPromo, // Tampilkan promo yang dipilih
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

