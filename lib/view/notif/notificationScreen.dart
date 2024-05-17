import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late List<String> notifications = [];

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notifications = prefs.getStringList('notifications') ?? [];
    });
  }

  Future<void> addNotification(String notification) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedNotifications = [...notifications, notification];
    await prefs.setStringList('notifications', updatedNotifications);
    setState(() {
      notifications = updatedNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Notification Title ${notifications[index]}'),
                    subtitle: Text('Notification Body ${notifications[index]}'),
                    onTap: () {
                      // Aksi yang akan dilakukan ketika notifikasi diklik
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
