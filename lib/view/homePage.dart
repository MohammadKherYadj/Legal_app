import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:legal_app/componant/myDrawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userInfo});
  final Map<String, String> userInfo;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("1".tr), backgroundColor: Color(0xffffcf40)),
        drawer: MyDrawer(userInfo: userInfo),
      ),
    );
  }
}
