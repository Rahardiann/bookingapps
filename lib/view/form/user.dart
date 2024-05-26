import 'package:booking/view/form/adduser.dart';
import 'package:booking/view/profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:booking/view/login.dart';
import 'package:booking/view/booking.dart';
import 'package:booking/view/home.dart';
import 'package:booking/view/form/editprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int id;
  final String nama;
  final int noRekamMedis;

  User({required this.id, required this.nama, required this.noRekamMedis});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
      noRekamMedis: json['no_rekam_medis'],
    );
  }
}

class Userprofile extends StatefulWidget {
  @override
  _UserProfilesState createState() => _UserProfilesState();
}

class _UserProfilesState extends State<Userprofile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool isLoading = false;
  List<User> user = [];
  User? currentUser;

  // Method to validate the form fields
  bool _validateForm() {
    if (_nameController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      // Show a snackbar or toast to inform the user to fill all fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
      return false;
    }
    return true;
  }

  int _selectedIndex = 2; // Set index sesuai dengan "Profile"

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

  Future<void> fetchUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? id = prefs.getInt('id_user');
      if (id == null) {
        print("User ID is null");
        setState(() {
          isLoading = false;
        });
        return;
      }
      String apiUrl = "http://82.197.95.108:8003/user/2/$id";
      Dio dio = Dio();
      Response response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data['data'];
        List<User> fetchedUser =
            responseData.map((json) => User.fromJson(json)).toList();

        setState(() {
          user = fetchedUser;
          if (user.isNotEmpty) {
            currentUser = user.first; // Assume the first user is the current user
          }
          isLoading = false;
        });
      } else {
        print("Error fetching user: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching user: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil lebar layar
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
              'User',
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                SizedBox(height: 20),
                if (currentUser != null)
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD7F0EE),
                      borderRadius: BorderRadius.circular(15), // Tambahkan border radius di sini
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 5.0, right: 8.0), // Margin di sebelah kiri ikon profil
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
                              currentUser!.nama, // Ganti dengan nama pengguna yang sesuai
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Medical record | ${currentUser!.noRekamMedis}', // Sub judul
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                for (var usr in user)
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD7F0EE),
                      borderRadius: BorderRadius.circular(15), // Tambahkan border radius di sini
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 5.0, right: 8.0), // Margin di sebelah kiri ikon profil
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
                              "usr.nama", // Ganti dengan nama pengguna yang sesuai
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Medical record | 009', // Sub judul
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Adduser()), // Sesuaikan dengan route halaman Edit Profile
            );
          },
          label: Text(
            'Add User',
            style: TextStyle(
                color: Colors.white), // Mengatur warna teks menjadi putih
          ),
          extendedPadding: EdgeInsets.symmetric(horizontal: 80),
          backgroundColor: Color(0xFF16A69A), // Warna latar belakang tombol
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
