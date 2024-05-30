import 'package:booking/view/form/addpassword.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:booking/view/regristasipage.dart';
import 'package:booking/view/home.dart';
import 'package:booking/widget/welcomepage.dart';
import 'package:booking/view/form/addpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

void _showDatePickerBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builder) {
      return Container(
        height: 300, // Sesuaikan dengan kebutuhan
        child: Column(
          children: [
            Expanded(
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                onDateChanged: (DateTime selectedDate) {
                  // Lakukan sesuatu dengan tanggal yang dipilih
                  print('Selected date: $selectedDate');
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}

class UserData {
  final String nama;
  final String email;
  final String no_hp;
  final String password;
  final String no_ktp;
  final String gender;

  UserData(
      {required this.nama,
      required this.email,
      required this.no_hp,
      required this.password,
      required this.no_ktp,
      required this.gender});
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
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _no_ktpController = TextEditingController();
  bool _obscureText = true;
  late UserData userData;

  // Method to validate the form fields
  bool _validateForm() {
    if (NameController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      // Show a snackbar or toast to inform the user to fill all fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
      return false;
    } else if (_emailController.text.isEmpty ||
        !_emailController.text.contains('@')) {
      // Show a snackbar or toast to inform the user to enter a valid email
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid email address.'),
        ),
      );
      return false;
    } else if (_passwordController.text.length < 8) {
      // Show a snackbar or toast to inform the user about the minimum password length
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password must be at least 8 characters.'),
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
    String no_ktp = _no_ktpController.text;
    String gender = _genderController.text;



    Dio dio = Dio();

    try {
      // Melakukan request ke endpoint registrasi
      Response response = await dio.post(
        'http://82.197.95.108:8003/user/registerlogin', // Ganti dengan URL endpoint registrasi yang sesuai
        data: {
          'email': email,
          'nama': nama,
          'no_hp': no_hp,
          'password': password,
          'no_ktp' : no_ktp,
          'gender' : gender
        },
      );

      // Menggunakan data response jika diperlukan
      print(response.data);

      // Jika registrasi berhasil, arahkan ke halaman Welcomepage
      if (response.statusCode == 200) {
        int id_exist = response.data['data']['id'];
        SharedPreferences.setMockInitialValues({});
        // Save user ID to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('id_exist', id_exist);
        
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Welcomepage()),
      );
      }
    } catch (error) {
      // Menangani error jika terjadi
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          // Status code 400 menunjukkan data sudah ada
          _showUserExistsDialog();
        } else {
          print(error.toString());
          _showErrorDialog();
        }
      } else {
        print(error.toString());
        _showErrorDialog();
      }
    }
  }

  void _showUserExistsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Already Exists'),
          content: Text(
              'This user already exists. Would you like to create a new password?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to password creation screen with the email
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddPasswordPage(email: _emailController.text),
                  ),
                );
              },
              child: Text('Create Password'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showBadRequestDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bad Request'),
          content: Text(
              'The request was not valid. Please check your input and try again.'),
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

  void _showErrorDialog() {
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

  @override
  void initState() {
    super.initState();
    userData = UserData(nama: '', email: '', no_hp: '', password: '', no_ktp: '', gender: '');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 60.0, // Adjust bottom padding for watermark
            ),
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
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '+62',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                        width:
                            8.0), // Memberikan sedikit ruang antara +62 dan TextFormField
                    Expanded(
                      child: TextFormField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Phone number',
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller:
                      NameController, // Menggunakan controller NameController
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    errorText: !_emailController.text.contains('@gmail.com') &&
                            _emailController.text.isNotEmpty
                        ? 'Please enter a valid email address.'
                        : null,
                  ),
                  keyboardType: TextInputType.emailAddress,
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
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    // Set errorText jika panjang kata sandi kurang dari 8 karakter
                    errorText: _passwordController.text.isNotEmpty &&
                            _passwordController.text.length < 8
                        ? 'Password must be at least 8 characters.'
                        : null,
                  ),
                  obscureText: _obscureText,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _no_ktpController,
                  decoration: InputDecoration(
                    labelText: 'NIK',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 1.0,
                        horizontal:
                            15.0), // Atur padding horizontal untuk mengatur lebar
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
                      value: 'pria',
                      groupValue: _genderController.text,
                      onChanged: (String? value) {
                        setState(() {
                          _genderController.text = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Female'),
                      value: 'wanita',
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
                SizedBox(
                    width: double.infinity,
                    height: 45, // Tinggi button
                    child: ElevatedButton(
                      onPressed: () {
                        // Validasi formulir
                        bool isValid = _validateForm();

                        // Perbarui tampilan pesan kesalahan pada TextField
                        setState(() {});

                        if (isValid) {
                          // Simpan data pengguna
                          userData = UserData(
                            nama: NameController.text,
                            email: _emailController.text,
                            no_hp: _phoneNumberController.text,
                            password: _passwordController.text,
                            no_ktp: _no_ktpController.text,
                            gender: _genderController.text,
                          );

                          // Periksa apakah pengguna sudah ada di database
                          _registerUser();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF16A69A), // Warna latar belakang
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white), // Warna teks
                      ),
                    )),
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
      NameController.dispose();
    _genderController.dispose();
    super.dispose();
  }
}
