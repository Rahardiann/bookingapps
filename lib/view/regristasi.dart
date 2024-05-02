import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:booking/view/regristasipage.dart';
import 'package:flutter/services.dart';
import 'package:booking/view/home.dart';
import 'package:booking/widget/welcomepage.dart';
 
class UserData {
  final String nama;
  final String email;
  final String no_hp;
  final String password;

  UserData({required this.nama, required this.email, required this.no_hp, required this.password});
}


class Register extends StatelessWidget {
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
        child: RegisterForm(),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController NameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  late UserData userData;

  // Method to validate the form fields
  bool _validateForm() {
    if (NameController.text.isEmpty ||
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

  Future<void> _registerUser() async {
    // Mengambil data dari controller
    String email = _emailController.text;
    String password = _passwordController.text;
    String nama = NameController.text;
    String no_hp = _phoneNumberController.text;
    


Dio dio = Dio();

    try {
      // Melakukan request ke endpoint registrasi
      Response response = await dio.post(
        'http://82.197.95.108:8003/user/register', // Ganti dengan URL endpoint registrasi yang sesuai
        data: {
          'email': email,
          'nama': nama,
          'no_hp': no_hp,
          'password': password,
          
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
  void initState() {
    super.initState();
    userData = UserData(nama: '', email: '', no_hp: '', password: '');
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 60.0), // Adjust bottom padding for watermark
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
                  'Please fill in the detailed information below',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(height: 10),
                TextFormField(
                  controller: _phoneNumberController, // Menggunakan controller _phoneNumberController
                  decoration: InputDecoration(
                    labelText: 'Phone number',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: NameController, // Menggunakan controller _phoneNumberController
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController, // Menggunakan controller _emailController
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureText,
                ),
                
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 45, // Tinggi button
                  child: ElevatedButton(
                  onPressed: () {
                    if (_validateForm()) {
                      // Save user data
                      userData = UserData(
                        nama: NameController.text,
                        email: _emailController.text,
                        no_hp: _phoneNumberController.text,
                        password: _passwordController.text,
                      );

                      // Navigate to next page with user data
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Regst(userData: userData)),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF16A69A), // Background color
                    ),
                    child: Text(
                      'next',
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                  // Button styling
                ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    NameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
