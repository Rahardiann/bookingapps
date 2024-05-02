
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:booking/view/booking.dart';
import 'package:booking/view/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:booking/view/form/detailpromo.dart';

class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class Dentist {
  final int id;
  final String nama;
  

  Dentist({required this.id, required this.nama});

  factory Dentist.fromJson(Map<String, dynamic> json) {
    return Dentist(
      id: json['id'],
      nama: json['nama'],
      
    );
  }
}

class User {
  final int id;
  final String nama;
  

  User({required this.id, required this.nama});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
      
    );
  }
}

class Jadwal {
  final int id;
  final DateTime  jadwal;
  final String jam;
  

  Jadwal({required this.id, required this.jadwal, required this.jam});

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      id: json['id'],
      jadwal: DateTime.parse(json['jadwal']),
      jam: json['jam'],
      
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _bottomNavCurrentIndex = 0;
  String _selectedUser = "User";
  String _selectedDentist = "Choose a dentist";
   DateTime _selectedDate = DateTime.now();
   String _selectedTimeText = 'Select Time';
   String _selectedPromo = "Promo";
   String _username = "";
   List<Dentist> dentists = [];
   List<User> user = [];
   List<Jadwal> jadwal = [];
   List<Jadwal> jam = [];
  List<Post> posts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _bottomNavCurrentIndex = 0;
    fetchData();
    fetchDentists();
    fetchUser();
    fetchJadwal();
  }
  
Future<void> fetchPosts() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Ganti URL ini dengan URL node yang benar
      String apiUrl = "http://82.197.95.108:8003/booking";
      
      // Membuat instance Dio
      Dio dio = Dio();
      
      // Melakukan HTTP GET request
      Response response = await dio.post(apiUrl);

      // Mengkonversi data JSON menjadi list of posts
      List<dynamic> responseData = response.data;
      List<Post> fetchedPosts = responseData.map((json) => Post.fromJson(json)).toList();

      setState(() {
        posts = fetchedPosts;
        isLoading = false;
      });
    } catch (e) {
      // Menampilkan pesan error jika terjadi kesalahan
      print("Error fetching posts: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

Future<void> fetchDentists() async {
  setState(() {
    isLoading = true;
  });

  try {
    String apiUrl = "http://82.197.95.108:8003/dokter";
    Dio dio = Dio();
    Response response = await dio.get(apiUrl);

    if (response.statusCode == 200) {
      print(response.data['data']);
      List<dynamic> responseData = response.data['data'];
      List<Dentist> fetchedDentists = responseData.map((json) => Dentist.fromJson(json)).toList();

      setState(() {
        dentists = fetchedDentists;
        isLoading = false;
      });
    } else {
      print("Error fetching dentists: ${response.statusCode}");
      setState(() {
        isLoading = false;
      });
    }
  } catch (e) {
    print("Error fetching dentists: $e");
    setState(() {
      isLoading = false;
    });
  }
}
Future<void> fetchUser() async {
  setState(() {
    isLoading = true;
  });

  try {
    String apiUrl = "http://82.197.95.108:8003/user";
    Dio dio = Dio();
    Response response = await dio.get(apiUrl);

    if (response.statusCode == 200) {
      print(response.data['data']);
      List<dynamic> responseData = response.data['data'];
      List<User> fetchedUser = responseData.map((json) => User.fromJson(json)).toList();

      setState(() {
        user = fetchedUser;
        isLoading = false;
      });
    } else {
      print("Error fetching user: ${response.statusCode}");
      setState(() {
        isLoading = false;
      });
    }
  } catch (e) {
    print("Error fetching dentists: $e");
    setState(() {
      isLoading = false;
    });
  }
}
Future<void> fetchJadwal() async {
  setState(() {
    isLoading = true;
  });

  try {
    String apiUrl = "http://82.197.95.108:8003/jadwal";
    Dio dio = Dio();
    Response response = await dio.get(apiUrl);

    if (response.statusCode == 200) {
      print(response.data['data']);
      List<dynamic> responseData = response.data['data'];
      List<Jadwal> fetchedJadwal = responseData.map((json) => Jadwal.fromJson(json)).toList();

      setState(() {
        jadwal = fetchedJadwal;
        isLoading = false;
      });
    } else {
      print("Error fetching jadwal: ${response.statusCode}");
      setState(() {
        isLoading = false;
      });
    }
  } catch (e) {
    print("Error fetching dentists: $e");
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

  void _showUserSelectionSheet(BuildContext context) {
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
                            'Bowo', // Ganti dengan nama pengguna yang sesuai
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
                      _selectedUser = 'Bowo';
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
                            'Bowo', // Ganti dengan nama pengguna yang sesuai
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Medical record | 002', // Sub judul
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
                      _selectedUser = 'Muller';
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
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: dentists.length,
            itemBuilder: (BuildContext context, int index) {
              Dentist dentist = dentists[index];
              return ListTile(
                title: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 20.0),
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
                          dentist.nama,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedDentist = dentist.nama;
                  });
                  Navigator.pop(context);
                },
              );
            },
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
                  itemCount: 10, // Misalnya, tampilkan 10 item
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFD7F0EE),
                        ),
                        padding: EdgeInsets.all(8),
                        child: TextFormField(
                          initialValue:
                              '08 : 00', // Atur nilai awal sesuai kebutuhan Anda
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            // Tambahkan logika di sini untuk menangani perubahan nilai jam
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      onTap: () {
                        // Tambahkan logika di sini untuk menangani pemilihan jam
                        var selectedTime =
                            '08 : 00'; // Ganti dengan nilai waktu yang dipilih
                        setState(() {
                          _handleTimeSelection(selectedTime);
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Detailpromo()),
                      );
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Detailpromo()),
                      );
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
                    _showUserSelectionSheet(
                        context); // Panggil method bottom sheet
                  },
                  icon: Icon(
                    Icons.person,
                    color: Color(0xFF16A69A),
                  ),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _selectedUser, // Tampilkan nama dentist yang dipilih
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
                    _showDentistSelectionSheet(
                        context); // Panggil method bottom sheet
                  },
                  icon: Icon(
                    Icons.medical_services,
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
                
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                           
                            backgroundColor: Color(0xFFE65895),
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

              ],
            ),
          ),


          TextButton(
             onPressed: () {
              _showPromoSelectionSheet(context);
            },
            child: Container(
             
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Promo',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                               color: Color(0xFFB6366D),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Colors.black,
                              ),
                              onPressed: () {},
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

