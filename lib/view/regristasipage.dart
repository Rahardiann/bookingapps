import 'package:booking/widget/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:booking/view/home.dart';
import 'package:booking/widget/welcomepage.dart';

class Regst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: RegstForm(),
      ),
    );
  }
}

class RegstForm extends StatefulWidget {
  @override
  _RegstFormState createState() => _RegstFormState();
}

class _RegstFormState extends State<RegstForm> {
  final TextEditingController _idCardController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

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
                  controller: _idCardController,
                  decoration: InputDecoration(
                    labelText: 'ID Card Number',
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
                TextFormField(
                  controller: _genderController,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 1.0,
                        horizontal:
                            15.0),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(
                    labelText: 'Date of birth',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
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
                      // Action when forgot password button is pressed
                    },
                    child: Text("Skip"),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 45, // Tinggi button
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Welcomepage()),
                      );
                    },
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
    _idCardController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
