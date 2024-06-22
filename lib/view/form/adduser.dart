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
              'Tambah user',
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noKtpController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birth = TextEditingController();
  bool _obscureText = true;
  bool _isValidForm = false;
  String? _gender;

  Future<void> _registerUser(BuildContext context) async {
    // Validate all fields are filled
    if (!_isValidForm) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
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
      return;
    }

    // Get data from controllers
    String email = _emailController.text;
    String password = _passwordController.text;
    String nama = _nameController.text;
    String no_hp = _phoneNumberController.text;
    String gender = _genderController.text;
    String address = _addressController.text;
    String no_ktp = _noKtpController.text;
    String tanggal_lahir = _birth.text;

    // Configuration for Dio
    Dio dio = Dio();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? id = prefs.getInt('id_user');

      Response response = await dio.post(
        'http://82.197.95.108:8003/user/registeruser', // Replace with your registration endpoint URL
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

      print(response.data); // Use response data if needed

      // Navigate to profile page if registration successful
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profiles()),
      );
    } catch (error) {
      // Handle errors
      print(error.toString());
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
                  controller: _nameController,
                  onChanged: (_) => _validateForm(),
                  decoration: InputDecoration(
                    labelText: 'Nama lengkap',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    errorText: _nameController.text.isEmpty
                        ? 'Silahkan masukkan nama lengkap.'
                        : null,
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
                        onChanged: (_) => _validateForm(),
                        decoration: InputDecoration(
                          labelText: 'Nomor telepon',
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 15.0),
                          errorText: _phoneNumberController.text.isEmpty
                              ? 'Silahkan masukkan nomor telepon.'
                              : (_phoneNumberController.text.length < 9 ||
                                      _phoneNumberController.text.length > 13)
                                  ? 'Nomor telepon harus minimal 9 dan 13 karakter.'
                                  : null,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(13), // Limit input to 13 characters
                        ],
                        maxLength: 13, // Set maximum length of input
                        minLength: 9, // Set minimum length of input
                      ),

                    ),

                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  onChanged: (_) => _validateForm(),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    errorText: !_emailController.text.contains('@') &&
                            _emailController.text.isNotEmpty
                        ? 'Silahkan masukkan email dengan benar.'
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
                        ? 'Password harus minimal 8 karakter.'
                        : null,
                  ),
                  obscureText: _obscureText,
                ),
                SizedBox(height: 20),
                
                Text(
                  'Jenis kelamin',
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
                          _validateForm();
                        });
                      },
                    ),
                    Text('Pria'),
                    Radio(
                      value: 'wanita',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value.toString();
                          _validateForm();
                        });
                      },
                    ),
                    Text('Wanita'),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _addressController,
                  onChanged: (_) => _validateForm(),
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    errorText: _addressController.text.isEmpty
                        ? 'Silahkan masukkan alamat.'
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _noKtpController,
                  onChanged: (_) => _validateForm(),
                  decoration: InputDecoration(
                    labelText: 'NIK',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 15.0),
                    errorText: _noKtpController.text.isEmpty
                        ? 'Silahkan masukkan NIK.'
                        : _noKtpController.text.length != 16
                            ? 'NIK harus 16 karakter.'
                            : null,
                  ),
                 keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16), // Limit input to 13 characters
                        ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _birth,
                  onChanged: (_) => _validateForm(),
                  decoration: InputDecoration(
                    labelText: 'Tanggal lahir',
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
                            _validateForm();
                          });
                        });
                      },
                    ),
                    errorText: _birth.text.isEmpty
                        ? 'Silahkan pilih tanggal lahir.'
                        : null,
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _isValidForm ? () => _registerUser(context) : null,
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF16A69A),
                    ),
                    child: Text(
                      'Tambah',
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
      _isValidForm = _emailController.text.contains('@') &&
    _emailController.text.isNotEmpty &&
    _passwordController.text.isNotEmpty &&
    _passwordController.text.length >= 8 &&
    _nameController.text.isNotEmpty &&
    _phoneNumberController.text.isNotEmpty &&
    _phoneNumberController.text.length <=13 && // Ensure exactly 13 characters
    _phoneNumberController.text.length >=9 && // Ensure exactly 13 characters
    _addressController.text.isNotEmpty &&
    _noKtpController.text.isNotEmpty &&
    _noKtpController.text.length == 16 &&
    _birth.text.isNotEmpty;

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




