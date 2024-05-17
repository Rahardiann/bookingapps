import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationData {
  final int id;
  final String title;
  final String body;

  NotificationData({required this.id, required this.title, required this.body});
}

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late BuildContext context; // Context untuk navigasi

  void initialize(BuildContext context) {
    this.context = context;
    var initializationSettingsAndroid = AndroidInitializationSettings(
        '@mipmap/ic_launcher'); // Sesuaikan dengan icon aplikasi Anda
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your_channel_id', // Ubah dengan channel id Anda
        'your_channel_name', // Ubah dengan channel name Anda
        channelDescription:
            'your_channel_description', // Ubah dengan deskripsi channel Anda
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    // Menambahkan notifikasi ke daftar
    NotificationData notification = NotificationData(
      id: 0, // Sesuaikan dengan id notifikasi Anda
      title: 'Booking Successful',
      body: 'Your appointment has been booked',
    );
    await flutterLocalNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: 'item x',
    );

    // Navigasi ke halaman notifikasi
    Navigator.pushNamed(context, '/booking');
  }
}
