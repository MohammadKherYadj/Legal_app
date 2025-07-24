import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/view/settings.dart';
import 'package:legal_app/view/profile/userProfile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.userInfo});
  final Map<String, String> userInfo;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("username"),
            accountEmail: Text("user email"),
          ),
          Expanded(
            child: ListView(
              children: [
                InkWell(
                  child: ListTile(title: Text("2".tr)),
                  onTap: () {
                    Get.to(UserProfile(userInfo: userInfo));
                  },
                ),
                InkWell(
                  child: ListTile(title: Text("3".tr)),
                  onTap: () {
                    Get.to(Settings());
                  },
                ),
                ListTile(title: Text("4".tr)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
