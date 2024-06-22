import 'package:booking/view/notif/reminder.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:booking/view/booking.dart';
import 'package:booking/view/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:booking/view/form/detailpromo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:booking/view/notif/notif.dart';
import 'package:booking/view/notif/notificationScreen.dart';
import 'package:booking/view/notif/reminder.dart';

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
  final String gambar;

  Dentist({required this.id, required this.nama, required this.gambar});

  factory Dentist.fromJson(Map<String, dynamic> json) {
    return Dentist(
      id: json['id'],
      nama: json['nama'],
      gambar: json['gambar'],
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

class NoRM {
  final int no_rekam_medis;

  NoRM({required this.no_rekam_medis});

  factory NoRM.fromJson(Map<String, dynamic> json) {
    return NoRM(
      no_rekam_medis: json['no_rekam_medis'],
    );
  }
}

class Jam {
  final int id;
  final DateTime jadwal;
  final String jam;

  Jam({required this.id, required this.jadwal, required this.jam});

  factory Jam.fromJson(Map<String, dynamic> json) {
    return Jam(
      id: json['id'],
      jadwal: DateTime.parse(json['jadwal']),
      jam: json['jam'],
    );
  }
}

class Jadwal {
  final int id;
  final List<String> jam;

  Jadwal({required this.id, required this.jam});

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      id: json['id'],
      jam: List<String>.from(json['jam']),
    );
  }
}

class Promo {
  final int id;
  final String judul;
  final String subtitle;
  final String gambar;
  final String deskripsi_1;
  final String deskripsi_2;

  Promo(
      {required this.id,
      required this.judul,
      required this.subtitle,
      required this.gambar,
      required this.deskripsi_1,
      required this.deskripsi_2});

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      id: json['id'],
      judul: json['judul'],
      subtitle: json['subtitle'],
      gambar: json['gambar'],
      deskripsi_1: json['deskripsi_1'],
      deskripsi_2: json['deskripsi_2'],
    );
  }
}

class BookingData {
  final int selectedDentistId;
  final int selectedUserId;
  final String selectedDentist;
  final DateTime selectedDate;
  final String selectedTime;
  final String selectedPromo;
  final int selectedPromoId;
  final int selectedJadwalId;

  BookingData({
    required this.selectedDentistId,
    required this.selectedUserId,
    required this.selectedDentist,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedPromo,
    required this.selectedPromoId,
    required this.selectedJadwalId,
  });
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NotificationService _notificationService = NotificationService();
  final NotificationRemindedr _notificationRemindedr = NotificationRemindedr();

  int _bottomNavCurrentIndex = 0;
  int _enteredNumber = 0;
  String _selectedUser = "User";
  String _selectedDentist = "Choose a dentist";
  DateTime _selectedDate = DateTime.now();
  // String _selectedTimeText = 'Select Time';
  String _selectedPromo = "Promo";
  String _username = "";
  List<Dentist> dentists = [];
  List<User> user = [];
  List<Jadwal> jadwal = [];
  List<Jam> jam = [];
  List<Promo> promo = [];
  List<Post> posts = [];
  bool isLoading = false;
  BookingData? bookingData;
  NoRM? noRM;
  String? _selectedTime;

  int _selectedDentistId = 0;
  int _selectedUserId = 0;
  int _selectedPromoId = 0;
  int _selectedJadwalId = 0;
  // Melakukan pengambilan data dan membuat objek BookingData

// Mengirim data bookingData ke server

  @override
  void initState() {
    super.initState();
    _notificationService.initialize(context);
    _notificationRemindedr.initNotification();
    _bottomNavCurrentIndex = 0;

    fetchData();
    fetchDentists();
    fetchUser();
    // fetchJadwal();
    fetchPromo();
  }

  Future<void> _bookingUser() async {
    Dio dio = Dio();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? id = prefs.getInt('id_user');
      // Melakukan request ke endpoint booking
      Response response = await dio.post(
        'http://82.197.95.108:8003/booking', // Ganti dengan URL endpoint booking yang sesuai
        data: {
          'user': {
            'id': _selectedUserId,
          },
          'dentist': {
            'id': _selectedDentistId,
            'nama': _selectedDentist,
          },
          'jadwal': {
            'jam': _selectedTime,
            'jadwal': _selectedDate.toIso8601String(),
          },
          'judul': _selectedPromo != null && _selectedPromoId != null
              ? {'id': _selectedPromoId, 'judul': _selectedPromo + "judul"}
              : null, 
        },
      );

      print(response.data);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Booking(
            bookingData:
                response.data, // Make sure to pass the correct booking data
          ),
          settings: RouteSettings(
            arguments: {
              'selectedUserId': _selectedUserId,
              'selectedDentistId': _selectedDentistId,
              'selectedDentist': _selectedDentist,
              'selectJadwalId': _selectedJadwalId,
              'selectedDate': _selectedDate,
              'selectedTimeText': _selectedTime,
              'selectedPromo': _selectedPromo,
              'selectedPromoId': _selectedPromoId,
            },
          ),
        ),
      );
    } on DioError catch (dioError) {
      if (dioError.response?.statusCode == 500) {
        // Show an error notification for 500 status code
        await (
          title: 'Booking Failed',
          body: 'You have already booked an appointment.',
        );

        _showAlert(
          title: 'Booking Failed',
          content: 'You have already booked an appointment.',
        );
      } else if (dioError.response?.statusCode == 200) {
        // Show a success alert for 200 status code
        _showAlert(
          title: 'Book Success',
          content: 'Your booking was accepted by admin.',
        );
      } else {
        // Handle other Dio errors
        _showAlert(
          title: 'Booking Error',
          content: 'An unexpected error occurred. Please try again.',
        );
        print(dioError.toString());
      }
    } catch (error) {
      // Handle non-Dio errors
      _showAlert(
        title: 'Error',
        content: 'An unexpected error occurred. Please try again.',
      );
      print(error.toString());
    }
  }


  void _showAlert({required String title, required String content}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
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
      List<Post> fetchedPosts =
          responseData.map((json) => Post.fromJson(json)).toList();

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
        List<Dentist> fetchedRM =
            responseData.map((json) => Dentist.fromJson(json)).toList();

        setState(() {
          dentists = fetchedRM;
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

  Future<void> fetchRM(String namaUser) async {
    setState(() {
      isLoading = true;
    });

    try {
      String apiUrl = "http://82.197.95.108:8003/user/$namaUser";
      Dio dio = Dio();
      Response response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        print(response.data['data']);
        setState(() {
          noRM = NoRM.fromJson(response.data['data']);
          isLoading = false;
        });
      } else {
        print("Error fetching RM: ${response.statusCode}");
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? id = prefs.getInt('id_user');
      String apiUrl = "http://82.197.95.108:8003/user/2/$id";
      Dio dio = Dio();
      Response response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        print(response.data['data']);
        List<dynamic> responseData = response.data['data'];
        List<User> fetchedUser =
            responseData.map((json) => User.fromJson(json)).toList();

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

  Future<void> fetchJadwal(int dentistID, String selectedDate) async {
    setState(() {
      isLoading = true;
    });

    try {
      String apiUrl = "http://82.197.95.108:8003/jadwal/$dentistID";
      Dio dio = Dio();
      Response response = await dio.get(
        apiUrl,
        data: {
          "tanggal_pemesanan": selectedDate,
        },
      );

      if (response.statusCode == 200) {
        print(response.data['data']);
        List<dynamic> responseData = response.data['data'];
        List<Jadwal> fetchedJadwal =
            responseData.map((json) => Jadwal.fromJson(json)).toList();

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
      print("Error fetching jadwal: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchPromo() async {
    setState(() {
      isLoading = true;
    });

    try {
      String apiUrl = "http://82.197.95.108:8003/promo";
      Dio dio = Dio();
      Response response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        print(response.data['data']);
        List<dynamic> responseData = response.data['data'];
        List<Promo> fetchedPromo =
            responseData.map((json) => Promo.fromJson(json)).toList();

        setState(() {
          promo = fetchedPromo;
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

  // Method untuk menampilkan bottom sheet

  void _showUserSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
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
                  height: 400, // Atur tinggi ListView sesuai kebutuhan
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: user.length,
                    itemBuilder: (BuildContext context, int index) {
                      User currentUser = user[index];
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
                                  currentUser.nama,
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
                        onTap: () async {
                          setState(() {
                            _selectedUser = currentUser.nama;
                            _selectedUserId = currentUser.id;
                          });
                          Navigator.pop(context);
                          await fetchRM(_selectedUser);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 20), // Jarak antara ListTile dan TextField
                // Tambahkan widget lain di sini jika diperlukan
                SizedBox(height: 80), // Jarak tambahan di bawah TextField
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
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "http://82.197.95.108:8003/dokter/gambar/${dentist.gambar}"),
                  ),
                  title: Text(
                    dentist.nama,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () async {
                    setState(() {
                      _selectedDentist = dentist.nama;
                      _selectedDentistId = dentist.id;
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
                      onPressed: () async {
                        Navigator.pop(context);
                        if (_selectedDentistId != null) {
                          await fetchJadwal(
                            _selectedDentistId,
                            _selectedDate.toIso8601String().substring(0, 10),
                          );
                        }
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
                child: CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 10),
                  onDateChanged: (DateTime newDateTime) {
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
  // Expanded(
  //   child: CupertinoDatePicker(
  //     mode: CupertinoDatePickerMode.date,
  //     minimumDate: DateTime.now(), // Hanya tampilkan tanggal hari ini dan seterusnya
  //     initialDateTime: _selectedDate,
  //     onDateTimeChanged: (DateTime newDateTime) {
  //       // Tambahkan logika di sini untuk menyimpan tanggal yang dipilih
  //       setState(() {
  //         _selectedDate = newDateTime;
  //       });
  //     },
  //   ),
  // ),

  void _handleTimeSelection(String selectedTime) {
    // Lakukan sesuatu dengan waktu yang dipilih
    print("Waktu yang dipilih: $selectedTime");
    setState(() {
      _selectedTime = selectedTime;
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
                  itemCount: jadwal.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height:
                                8), // Menambahkan spasi antara ID dan daftar jam
                        ...jadwal[index].jam.map((time) {
                          return ListTile(
                            title: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFFD7F0EE),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Text(
                                time, // Menggunakan setiap waktu dari daftar jam
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () async {
                              setState(() {
                                _handleTimeSelection(time);
                              });
                              Navigator.pop(context);
                            },
                          );
                        }).toList(),
                      ],
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

  Future<void> _saveUserIdToSharedPreferences(int promoId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selected_promo_id', promoId);
  }

  void _showPromoSelectionSheet(BuildContext context, List<Promo> promos) {
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
              child: ListView.builder(
                itemCount: promos.length,
                itemBuilder: (context, index) {
                  Promo promo = promos[index];
                  return TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedPromo = promo.judul;
                        _selectedPromoId = promo.id;
                      });
                      Navigator.pop(context);
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
                                      promo.judul,
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
                                      onPressed: () async{
                                      await _saveUserIdToSharedPreferences(promo.id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Detailpromo(),
                                        ),
                                      );
                                    },
                                    ),
                                  ],
                                ),
                                // Add vertical space between title and description
                                Text(
                                  promo
                                      .subtitle, // Using the subtitle property from the Promo object
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
                  );
                },
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
                    IconButton(
                      icon: Icon(
                        Icons.notifications_none_outlined,
                        size: 30,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        // Navigasi ke NotificationScreen saat ikon notifikasi ditekan
                        Navigator.pushNamed(context, '/notifikasi');
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.account_circle,
                        size: 30,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        // Navigasi ke AccountScreen saat ikon akun ditekan
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profiles()),
                        );
                      },
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
                  'assets/slide2.jpeg',
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
                        _selectedUser,
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
                        _selectedTime ??
                            'Select time', // Tampilkan waktu yang dipilih jika tersedia, jika tidak, tampilkan "Select time"
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
                    _showPromoSelectionSheet(context, promo);
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
                            _bookingUser();
                         
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => Booking(),
                            //   ),
                            // );
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
              _showPromoSelectionSheet(context, promo);
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
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
              onPressed: () {
                _showPromoSelectionSheet(context, promo);
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
              MaterialPageRoute(
                  builder: (context) => Booking(
                        bookingData: bookingData,
                      )),
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
