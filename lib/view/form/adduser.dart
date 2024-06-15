import 'package:booking/view/profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:booking/view/home.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
void _showDatePickerBottomSheet(
    BuildContext context, Function(DateTime) onDateSelected) {
  DateTime? selectedDate;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext builder) {
      return Container(
        height: 300,
        child: Column(
          children: [
            Expanded(
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                onDateChanged: (DateTime date) {
                  selectedDate = date;
                },
              ),
            ),
            TextButton(
              onPressed: () {
                if (selectedDate != null) {
                  onDateSelected(selectedDate!);
                }
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}
class Adduser extends StatelessWidget {
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
              'Add user',
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
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: RegistrationForm(),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rekamController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noKtpController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birth = TextEditingController();
  bool _obscureText = true;
  bool _isValidForm = false;
  String? _gender;

  Future<void> _registerUser() async {
    // Mengambil data dari controller
    String email = _emailController.text;
    String password = _passwordController.text;
    String nama = _nameController.text;
    String no_hp = _phoneNumberController.text;
    String gender = _genderController.text;
    String address = _addressController.text;
    String no_ktp = _noKtpController.text;
    String tanggal_lahir = _birth.text;

    // Konfigurasi objek Dio
    Dio dio = Dio();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? id = prefs.getInt('id_user');


      Response response = await dio.post(
        'http://82.197.95.108:8003/user/registeruser', // Ganti dengan URL endpoint registrasi yang sesuai
        data: {
          'id_login': id,
          'email': email,
          'gender': gender,
          'nama': nama,
          'no_hp': no_hp,
          'password': password,
          'alamat': address,
          'no_ktp': no_ktp,
          'tanggal_lahir': tanggal_lahir,
        },
      );

      // Menggunakan data response jika diperlukan
      print(response.data);

      // Jika registrasi berhasil, arahkan ke halaman Welcomepage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profiles()),
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
            padding: EdgeInsets.only(bottom: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  onChanged: (_) => _validateForm(),
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
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  onChanged: (_) => _validateForm(),
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
                    errorText: _passwordController.text.isNotEmpty &&
                            _passwordController.text.length < 8
                        ? 'Password must be at least 8 characters.'
                        : null,
                  ),
                  obscureText: _obscureText,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
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
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          controller: _phoneNumberController,
                          decoration: InputDecoration(
                            labelText: 'Phone number',
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 15.0),
                          ),
                          keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                          validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Phone Number';
                      } else if (value.length > 13) {
                        return 'NIK must be at least 13 characters';
                      }
                      return null;
                    },
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                Text(
                  'Gender',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: 'pria',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value.toString();
                        });
                      },
                    ),
                    Text('Male'),
                    Radio(
                      value: 'wanita',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value.toString();
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                    controller: _noKtpController,
                    decoration: InputDecoration(
                      labelText: 'NIK',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 15.0),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your NIK';
                      } else if (value.length != 16) {
                        return 'NIK must be exactly 16 characters';
                      }
                      return null;
                    },
                  ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _birth,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _showDatePickerBottomSheet(context, (selectedDate) {
                          setState(() {
                            _birth.text =
                                selectedDate.toIso8601String().split('T')[0];
                          });
                        });
                      },
                    ),
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                   child: ElevatedButton(
                  onPressed: _isValidForm ? _registerUser : null, // Tambahkan pengecekan _isValidForm
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF16A69A),
                  ),
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
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
  void _validateForm() {
  setState(() {
    _isValidForm = _emailController.text.contains('@gmail.com') &&
        _passwordController.text.isNotEmpty &&
        _passwordController.text.length >= 8;
        _noKtpController.text.length >= 16;
    // Tambahkan validasi untuk TextFormField lainnya sesuai kebutuhan
  });
}

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _noKtpController.dispose();
    super.dispose();
  }
}
