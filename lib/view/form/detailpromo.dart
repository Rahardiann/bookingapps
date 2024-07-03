import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Promo {
  final int id;
  final String judul;
  final String subtitle;
  final String gambar;
  final String deskripsi_1;
  final String deskripsi_2;

  Promo({
    required this.id,
    required this.judul,
    required this.subtitle,
    required this.gambar,
    required this.deskripsi_1,
    required this.deskripsi_2,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      id: json['id'],
      judul: json['judul'],
      subtitle: json['subtitle'],
      gambar: json['gambar'],
      deskripsi_1: json['deskripsi_1'],
      deskripsi_2: json['deskripsi_2'],
    );
  }
}

class Detailpromo extends StatefulWidget {
  @override
  _DetailpromoState createState() => _DetailpromoState();
}

class _DetailpromoState extends State<Detailpromo> {
  int _bottomNavCurrentIndex = 1;
  Promo? promo;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _bottomNavCurrentIndex = 0;
    fetchPromo();
  }

  Future<void> fetchPromo() async {
  setState(() {
    isLoading = true;
  });

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? promoId = prefs.getInt('selected_promo_id');
    
    if (promoId == null) {
      throw Exception('No promo ID found in shared preferences');
    }

    String apiUrl = "http://82.197.95.108:8003/promo/$promoId";
    Dio dio = Dio();
    Response response = await dio.get(apiUrl);

    if (response.statusCode == 200) {
      var responseData = response.data['data'];
      
      if (responseData is List && responseData.isNotEmpty) {
        setState(() {
          promo = Promo.fromJson(responseData[0]); // Assuming you want the first promo in the list
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print("Error fetching promo: response data is not a list or is empty");
      }
    } else {
      print("Error fetching promo: ${response.statusCode}");
      setState(() {
        isLoading = false;
      });
    }
  } catch (e) {
    print("Error fetching promo: $e");
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                  Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Promo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(width: 48),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : promo == null
              ? Center(child: Text("No promo data available"))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                             child: Image.network(
                            "http://82.197.95.108:8003/dokter/gambar/${promo!.gambar}",
                              width: screenWidth * 0.4,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          promo!.judul,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          promo!.subtitle,
                          style: TextStyle(fontSize: 16, color: Colors.black38),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Welcome to Sarlita Dental Care! As an expression of gratitude for your trust, we are very happy to provide special promotions to our new patients. With this promo, you will enjoy high-quality dental health services at special prices.',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Terms and conditions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1. ',
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                            Expanded(
                              child: Text(
                                promo!.deskripsi_1,
                                style: TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '2. ',
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                            Expanded(
                              child: Text(
                                'To avail of this discount, you need to mention or present the promotional code provided at the time of booking or your first promo.',
                                style: TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '3. ',
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                            Expanded(
                              child: Text(
                                'This discount is only valid for a certain period. Make sure to claim it before the deadline expires.',
                                style: TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '4. ',
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                            Expanded(
                              child: Text(
                                'This discount cannot be combined with any other offers or promotions currently running at our clinic.',
                                style: TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Additional Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          promo!.deskripsi_2,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
    );
  }
}
