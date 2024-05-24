import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:booking/widget/welcomepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPasswordPage extends StatefulWidget {
  final String email;

  AddPasswordPage({required this.email});

  @override
  _AddPasswordPageState createState() => _AddPasswordPageState();
}

class _AddPasswordPageState extends State<AddPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureText = true;

  Future<void> _addPassword() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      // Show an error if passwords do not match
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match.'),
        ),
      );
      return;
    }

    try {
      // Make a request to the endpoint to add password
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? id = prefs.getInt('id_exist');
      Dio dio = Dio();
      Response response = await dio.put(
        'http://82.197.95.108:8003/user/exist/$id', // Replace with your endpoint
        data: {
          'password': _passwordController.text,
        },
      );

      // Handle the response as needed
      print(response.data);

      // Navigate to welcome page on success
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Welcomepage()),
      );
    } catch (error) {
      print(error.toString());
      // Show an error dialog if the request fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add password. Please try again.'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Add a new password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility),
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
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              obscureText: _obscureText,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: _addPassword,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF16A69A),
                ),
                child: Text(
                  'Add Password',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
