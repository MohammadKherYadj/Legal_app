import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:legal_app/componant/myButton.dart';
// import 'package:legal_app/componant/myTextFeild.dart';
import 'package:legal_app/view/homePage.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key, required this.userInfo});
  final Map<String, String> userInfo;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => UserProfile(
                            userInfo: {
                              'Name': 'John Doe',
                              'Email': 'john@example.com',
                              'Phone': '+1234567890',
                              'Gender': 'Male',
                              'Birthdate': '1990-01-01',
                              'Address': '123 Street',
                              // Add other fields you want to display
                            },
                          ),
                    ),
                  );
                },
                child: Text('View Profile'),
              ),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/default_avatar.png'),
                ),
              ),
              SizedBox(height: 20),
              ...widget.userInfo.entries
                  .map((entry) => buildInfoTile(entry.key, entry.value))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 16)),
          Divider(),
        ],
      ),
    );
  }
}

void update() {
  Get.to(HomePage(userInfo: {}));
}
