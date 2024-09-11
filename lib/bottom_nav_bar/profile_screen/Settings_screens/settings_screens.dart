import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatefulWidget {
  @override
  _PrivacySettingsScreenState createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  Map<String, bool> toggleStates = {
    'profileEveryone': true,
    'profileFriends': false,
    'friendRequestEveryone': true,
    'friendRequestFriends': false,
    'friendRequestMatch': false,
    'imagesEveryone': true,
    'imagesFriends': false,
    'pagesEveryone': true,
    'pagesFriends': false,
    'pagesMe': false,
    'purchaseEveryone': true,
    'purchaseFriends': false,
    'purchaseMe': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Privacy Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          _buildSection('Profile Visibility', [
            _buildToggleRow('Everyone', 'profileEveryone'),
            _buildToggleRow('Friends', 'profileFriends'),
          ]),
          _buildSection('Friend Request', [
            _buildToggleRow('Everyone', 'friendRequestEveryone'),
            _buildToggleRow('Friends', 'friendRequestFriends'),
            _buildToggleRow('Match my profile', 'friendRequestMatch'),
          ]),
          _buildSection('Images', [
            _buildToggleRow('Everyone', 'imagesEveryone'),
            _buildToggleRow('Friends', 'imagesFriends'),
          ]),
          _buildSection('Pages & Interest follow', [
            _buildToggleRow('Everyone', 'pagesEveryone'),
            _buildToggleRow('Friends', 'pagesFriends'),
            _buildToggleRow('Me', 'pagesMe'),
          ]),
          _buildSection('Purchase & Product review', [
            _buildToggleRow('Everyone', 'purchaseEveryone'),
            _buildToggleRow('Friends', 'purchaseFriends'),
            _buildToggleRow('Me', 'purchaseMe'),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.pink,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        Divider(height: 1, thickness: 1, color: Colors.grey[300]),
      ],
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
}