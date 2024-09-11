import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  _NotificationSettingsScreenState createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  Map<String, bool> toggleStates = {
    'pushNotification': true,
    'allNotifications': false,
    'chatNotifications': false,
    'orderStatusNotifications': false,
    'feedStatusNotifications': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Policies'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: ListView(
        children: [
          _buildToggleRow('Push Notification', 'pushNotification'),
          _buildToggleRow('All Notifications', 'allNotifications'),
          _buildToggleRow('Chat Notifications', 'chatNotifications'),
          _buildToggleRow('Order status Notifications', 'orderStatusNotifications'),
          _buildToggleRow('Feed status Notifications', 'feedStatusNotifications'),
          _buildDisclosureRow('Mail Notifications'),
          _buildDisclosureRow('SMS Notifications'),
        ],
      ),
    );
  }

  Widget _buildToggleRow(String label, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Switch(
            value: toggleStates[key]!,
            onChanged: (bool value) {
              setState(() {
                toggleStates[key] = value;
              });
            },
            activeColor: Colors.pink,
          ),
        ],
      ),
    );
  }

  Widget _buildDisclosureRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}