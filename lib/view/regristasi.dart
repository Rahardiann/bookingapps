import 'package:booking/view/form/addpassword.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:booking/widget/welcomepage.dart';
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

class UserData {
  final String nama;
  final String email;
  final String no_hp;
  final String password;
  final String no_ktp;
  final String gender;
  final String tanggal_lahir;

  UserData({
    required this.nama,
    required this.email,
    required this.no_hp,
    required this.password,
    required this.no_ktp,
    required this.gender,
    required this.tanggal_lahir,
  });
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController NameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _no_ktpController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  bool _obscureText = true;
  bool _isFormValid = false;
  late UserData userData;

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  Future<void> _registerUser() async {
    Dio dio = Dio();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('id_exist');

    String email = _emailController.text;
    String password = _passwordController.text;
    String nama = NameController.text;
    String no_hp = _phoneNumberController.text;
    String no_ktp = _no_ktpController.text;
    String gender = _genderController.text;
    String tanggal_lahir = _birthController.text;

    try {
      Response response = await dio.post(
        'http://82.197.95.108:8003/user/registerlogin',
        data: {
          'email': email,
          'nama': nama,
          'no_hp': no_hp,
          'password': password,
          'no_ktp': no_ktp,
          'gender': gender,
          'tanggal_lahir': tanggal_lahir,
        },
      );

      int id_exist = response.data['data']['id'];
      await prefs.setInt('id_exist', id_exist);
      print(id_exist);

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Welcomepage()),
        );
      } else {
        if (response.statusCode == 200) {
          _showUserExistsDialog();
        } else {
          _showErrorDialog();
        }
      }
    } catch (error) {
      print(error.toString());
      _showErrorDialog();
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
    userData = UserData(
        nama: '',
        email: '',
        no_hp: '',
        password: '',
        no_ktp: '',
        gender: '',
        tanggal_lahir: '');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: _validateForm,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 60.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hello! Selamat datang 👋',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Silahkan lengkapi data dibawah ini',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 50),
                  TextFormField(
                    controller: NameController,
                    decoration: InputDecoration(
                      labelText: 'Nama lengkap',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Silahkan masukkan nama lengkap';
                      }
                      return null;
                    },
                  ),
                  
                  SizedBox(height: 10),
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
                            labelText: 'Nomor telepon',
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
                              return 'Silahkan masukkan Nomor telepon';
                            } else if (value.length < 9 || value.length > 13) {
                              return 'Nomor Telepon harus minimal 9 dan 13 karakter';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Silahkan masukkan email';
                      } else if (!value.contains('@')) {
                        return 'Silahkan masukkan email dengan benar';
                      }
                      return null;
                    },
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
                    ),
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Silahkan masukkan password';
                      } else if (value.length < 8) {
                        return 'Password harus minimal 8 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _no_ktpController,
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
                        return 'Silahkan masukkan NIK';
                      } else if (value.length != 16) {
                        return 'NIK harus 16 karakter';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jenis kelamin',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      RadioListTile<String>(
                        title: const Text('Pria'),
                        value: 'pria',
                        groupValue: _genderController.text,
                        onChanged: (String? value) {
                          setState(() {
                            _genderController.text = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Wanita'),
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
                  TextFormField(
                    controller: _birthController,
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
                              _birthController.text =
                                  selectedDate.toIso8601String().split('T')[0];
                            });
                          });
                        },
                      ),
                    ),
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Silahkan pilih tanggal lahirh';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: _isFormValid
                          ? () {
                              userData = UserData(
                                nama: NameController.text,
                                email: _emailController.text,
                                no_hp: _phoneNumberController.text,
                                password: _passwordController.text,
                                no_ktp: _no_ktpController.text,
                                gender: _genderController.text,
                                tanggal_lahir: _birthController.text,
                              );

                              _registerUser();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF16A69A),
                      ),
                      child: Text(
                        'Lanjut',
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
      ),
    );
  }

  @override
  void dispose() {
    NameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _no_ktpController.dispose();
    _genderController.dispose();
    _birthController.dispose();
    super.dispose();
  }
}
