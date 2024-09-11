import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    Future<void> logout() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('jwtToken');

      // Navigate back to the login screen
      Navigator.pushReplacementNamed(context, '/login');
    }

    return SizedBox(
      height: h / 5.5,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              const Text('Jees kary_10',
                  style: TextStyle(
                      color: AppColors.textFieldColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: 15)),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person_outline),
                  ),
                  const SizedBox(width: 16),
                  Table(
                    columnWidths: {
                      0: FixedColumnWidth(w / 5),
                      1: FixedColumnWidth(w / 5),
                      2: FixedColumnWidth(w / 5),
                    },
                    children: const [
                      TableRow(
                        children: [
                          Center(
                              child: Text('121',
                                  style: TextStyle(
                                      color: AppColors.textFieldColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      fontSize: 12))),
                          Center(
                              child: Text('102',
                                  style: TextStyle(
                                      color: AppColors.textFieldColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      fontSize: 12))),
                          Center(
                              child: Text('201',
                                  style: TextStyle(
                                      color: AppColors.textFieldColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      fontSize: 12))),
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(
                              child: Text('Posts',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      fontSize: 12))),
                          Center(
                              child: Text('Followers',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      fontSize: 12))),
                          Center(
                              child: Text('Following',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      fontSize: 12))),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Text('Jees kary',
                  style: TextStyle(
                      color: AppColors.textFieldTextColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: 11)),
              const Text('Be the best IT provider in the town',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: 11)),
            ],
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 4, right: 4),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.textFieldColor
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: GestureDetector(
                  onTap: () {
                    // Show logout confirmation SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logging out...'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    // Call the logout method after a short delay
                    Future.delayed(const Duration(seconds: 2), logout);
                  },
                  child: const Text('Edit Profile',
                      style: TextStyle(
                          color: AppColors.textFieldColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontSize: 11)),
                ),
              ))
        ],
      ),
    );
  }
}
