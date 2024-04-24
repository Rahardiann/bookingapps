import 'package:flutter/material.dart';
import 'package:booking/view/home.dart';
import 'package:booking/view/regristasi.dart';

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
              'Edit Profile',
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
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _medicalController = TextEditingController();
   final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _identycardrController = TextEditingController();
   final TextEditingController _DateofbirthController = TextEditingController();
    final TextEditingController _AdressController = TextEditingController();
  bool _obscureText = true;
  String? _gender;

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
                SizedBox(height: 10),
                TextFormField(
                  controller: _medicalController,
                  decoration: InputDecoration(
                    labelText: 'Medical record number',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _phonenumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone number',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
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
                  controller: _identycardrController,
                  decoration: InputDecoration(
                    labelText: 'Identy card number',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Gender', // Label untuk tombol radio
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: 'male',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value.toString();
                        });
                      },
                    ),
                    Text('Male'),
                    Radio(
                      value: 'female',
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
                  controller: _DateofbirthController,
                  decoration: InputDecoration(
                    labelText: 'Date of birth',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _AdressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45, // Tinggi button
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF16A69A), // Background color
                    ),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                  ),
                ),
                SizedBox(height: 10),
                
              ],
            ),
          ),
        ),
        // Watermark Andes Studio
        // Positioned(
        //   left: 0,
        //   right: 0,
        //   bottom: 0,
        //   child: Container(
        //     padding: EdgeInsets.all(10),
        //     color: Colors.white.withOpacity(0.5),
        //     child: Text(
        //       'Andes Studio',
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         color: Colors.black,
        //         fontSize: 12,
        //         fontStyle: FontStyle.italic,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    
    super.dispose();
  }
}
