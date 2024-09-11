import 'package:flutter/material.dart';
import 'soco_Policies.dart';

class PoliciesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E63), // Pink color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Policies', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: const [
            PolicyItem(title: 'Terms of use'),
            PolicyItem(title: 'Data Policies'),
            PolicyItem(title: 'Privacy policies'),
            PolicyItem(title: 'Cookie Policies'),
            PolicyItem(title: 'Community Policies'),
          ],
        ),
      ),
    );
  }
}

class PolicyItem extends StatelessWidget {
  final String title;

  const PolicyItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
         if(title =='Privacy policies'){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationSettingsScreen()));
         }
        },
      ),
    );
  }
}