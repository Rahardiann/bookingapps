import 'package:booking/widget/welcomepage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:booking/view/home.dart';
import 'package:booking/widget/welcomepage.dart';

import 'regristasi.dart';


// class _Regst extends StatelessWidget {
//   final UserData userData;

//   Regst({required this.userData});

//   @override
//   Widget build(BuildContext context) {
//     return Text("email: " + userData.email);
//   }
// }

class Regst extends StatelessWidget {

    final UserData userData;

  Regst({required this.userData});


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
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: RegstForm(userData: userData,),
      ),
    );
  }
}

class RegstForm extends StatefulWidget {


  final UserData userData;

  RegstForm({required this.userData});

  @override
  _RegstFormState createState() => _RegstFormState(userData: userData);
}

class _RegstFormState extends State<RegstForm> {

      final UserData userData;

  _RegstFormState({required this.userData});
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _no_hpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _no_ktpController = TextEditingController();
  bool _obscureText = true;

  Future<void> _registerUser() async {
    // Mengambil data dari controller
    String email = _EmailController.text;
    String password = _passwordController.text;
    String nama = _namaController.text;
    String no_hp = _no_hpController.text;
    String gender = _genderController.text;
    String address = _addressController.text;
    String no_ktp = _no_ktpController.text;
    
    
    // Konfigurasi objek Dio
    Dio dio = Dio();

    try {
      // Melakukan request ke endpoint registrasi
      Response response = await dio.post(
        'http://82.197.95.108:8003/user/register', // Ganti dengan URL endpoint registrasi yang sesuai
        data: {
          'email': userData.email,
          'gender': gender,
          'nama': userData.nama,
          'no_hp': userData.no_hp,
          'password': userData.password,
          'alamat': address,
          'no_ktp': no_ktp,
          
        },
      );

      // Menggunakan data response jika diperlukan
      print(response.data);

      // Jika registrasi berhasil, arahkan ke halaman Welcomepage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Welcomepage()),
      );
    } catch (error) {
      // Menangani error jika terjadi
      print(error.toString());
      // Tampilkan pesan kesalahan kepada pengguna
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to register. Please try again.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
  children: [
    SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: 60.0), // Adjust bottom padding for watermark
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello! Welcome 👋',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Before seeing the notification you get, log in first',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 50),
            TextFormField(
              controller: _no_ktpController,
              decoration: InputDecoration(
                labelText: 'ID Card Number',
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(
                    vertical: 1.0,
                    horizontal: 15.0), // Atur padding horizontal untuk mengatur lebar
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                RadioListTile<String>(
                  title: const Text('Male'),
                  value: 'Male',
                  groupValue: _genderController.text,
                  onChanged: (String? value) {
                    setState(() {
                      _genderController.text = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Female'),
                  value: 'Female',
                  groupValue: _genderController.text,
                  onChanged: (String? value) {
                    setState(() {
                      _genderController.text = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Welcomepage()),
                  );
                },
                child: Text("Skip"),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 45, // Tinggi button
              child: ElevatedButton(
                onPressed: _registerUser, // Panggil fungsi registrasi saat tombol ditekan
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF16A69A), // Background color
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white), // Text color
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account yet?"),
                TextButton(
                  onPressed: () {
                    //   Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Register()),
                    // );
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ],
);

  }

  @override
  void dispose() {
    _EmailController.dispose();
    _genderController.dispose();
    _namaController.dispose();
    _no_hpController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
