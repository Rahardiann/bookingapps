import 'package:booking/view/form/user.dart';
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

class VisitUser {
  final String nama;
  final String email;
  final int? no_rekam_medis;
  final String? no_hp;
  final String? password;
  final String? gender;
  final String? alamat;
  final String? no_ktp;
  final String tanggal_lahir;

  VisitUser({
    required this.nama,
    required this.email,
    required this.tanggal_lahir,
    this.no_rekam_medis,
    this.no_hp,
    this.password,
    this.gender,
    this.alamat,
    this.no_ktp,
  });

  factory VisitUser.fromJson(Map<String, dynamic> json) {
    return VisitUser(
      nama: json['nama'] ?? '',
      email: json['email'] ?? '',
      no_rekam_medis: json['no_rekam_medis'],
      no_hp: json['no_hp'] ?? '',
      password: json['password'] ?? '',
      gender: json['gender'] ?? '',
      alamat: json['alamat'] ?? '',
      no_ktp: json['no_ktp']?? '',
      tanggal_lahir: json['tanggal_lahir'] ?? '',
    );
  }
}


class EditProfile extends StatelessWidget {
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
              'Edit Profile',
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
  final TextEditingController _birth = TextEditingController();
  bool _obscureText = true;
  String? _gender;
  VisitUser? _visitUser;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchVisit();
  }

  Future<void> _editUser() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    int no_rekam_medis = int.tryParse(_rekamController.text) ?? 0;
    String nama = _nameController.text;
    String no_hp = _phoneNumberController.text;
    String gender = _gender ?? '';
    String alamat = _addressController.text;
    String tanggal_lahir = _birth.text;
    String no_ktp = _noKtpController.text;

    VisitUser _visitUser = VisitUser(
      email: email,
      password: password,
      no_rekam_medis: no_rekam_medis,
      nama: nama,
      no_hp: no_hp,
      gender: gender,
      alamat: alamat,
      no_ktp: no_ktp,
      tanggal_lahir: tanggal_lahir,
    );

    Dio dio = Dio();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? id = prefs.getInt('id_user');
      Response response = await dio.put(
        'http://82.197.95.108:8003/user/$id',
        data: {
          'email': _visitUser.email,
          'nama': _visitUser.nama,
          'no_rekam_medis': _visitUser.no_rekam_medis,
          'no_hp': _visitUser.no_hp,
          'password': _visitUser.password,
          'gender': _visitUser.gender,
          'alamat': _visitUser.alamat,
          'no_ktp': _visitUser.no_ktp,
          'tanggal_lahir': _visitUser.tanggal_lahir,
        },
      );

      
      print(response.data);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (error) {
      print(error.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update profile. Please try again.'),
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

  Future<void> fetchVisit() async {
  setState(() {
    isLoading = true;
  });

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id_user');

    String apiUrl = "http://82.197.95.108:8003/user/2/$id";
    Dio dio = Dio();
    Response response = await dio.get(apiUrl);
    print(response.data['data']);

    if (response.statusCode == 200) {
      var responseData = response.data['data'];
      if (responseData is List) {
        if (responseData.isNotEmpty) {
          responseData = responseData.first;
        } else {
          throw Exception("User data list is empty");
        }
      }

      _visitUser = VisitUser.fromJson(responseData);

      setState(() {
        String password = '';
        _emailController.text = _visitUser?.email ?? '';
        _passwordController.text = password ;
        _rekamController.text = (_visitUser?.no_rekam_medis ?? 0).toString();
        _nameController.text = _visitUser?.nama ?? '';
        _phoneNumberController.text = _visitUser?.no_hp ?? '';
        _gender = _visitUser?.gender ?? '';
        _addressController.text = _visitUser?.alamat ?? '';
        _birth.text = _visitUser?.tanggal_lahir ?? '';
       _noKtpController.text = (_visitUser?.no_ktp ?? 0).toString();
        isLoading = false;
      });
    } else {
      print("Error fetching user data: ${response.statusCode}");
      setState(() {
        isLoading = false;
      });
    }
  } catch (e) {
    print("Error: $e");
    setState(() {
      isLoading = false;
    });
  }
}


  @override 
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Stack(
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
                        decoration: InputDecoration(
                          labelText: 'Nama lengkap',
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
                      } else if (value.length > 13) {
                        return 'Nomor telepon harus maksimal 13 karakter';
                      }
                      return null;
                    },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        obscureText: _obscureText,
                      ),
                      // SizedBox(height: 20),
                      // TextFormField(
                      //   controller: _rekamController,
                      //   decoration: InputDecoration(
                      //     labelText: 'No Rekam Medis',
                      //     border: InputBorder.none,
                      //     filled: true,
                      //     fillColor: Colors.grey[200],
                      //   ),
                        
                      // ),
                     
                      
                      
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
                              });
                            },
                          ),
                          Text('Wanita'),
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
                        return 'Silahkan masukkan NIK';
                      } else if (value.length != 16) {
                        return 'NIK harus 16 karakter';
                      }
                      return null;
                    },
                  ),
                       SizedBox(height: 20),
                      TextFormField(
                  controller: _birth,
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
                          onPressed: _editUser,
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF16A69A),
                          ),
                          child: Text(
                            'Edit',
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
