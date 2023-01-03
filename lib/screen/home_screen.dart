import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_app1/utils/my_themes.dart';
import '../db/sql_helper.dart';
import '../screen/view_screen.dart';

import 'add_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    SQLHelper.initializeSqlDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Homepage',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedButton.icon(
              onPressed: () => Get.to(const AddScreen()),
              icon: const Icon(
                Icons.add,
                color: MyThemes.primary,
              ),
              label: const Text(
                'add',
                style: TextStyle(
                  color: MyThemes.primary,
                ),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyThemes.primary,
              ),
              onPressed: () => Get.to(const ViewScreen()),
              icon: const Icon(
                Icons.remove_red_eye,
                color: Colors.white,
              ),
              label: const Text(
                "View",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
