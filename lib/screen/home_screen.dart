import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_app1/components/elevation_button_widget.dart';
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
            ElevationButtonWidget(
              onPressed: () => Get.to(const AddScreen()),
              icon: Icons.add,
              backgroundColor: MyThemes.white,
              textStyleColor: MyThemes.primary,
            ),
            ElevationButtonWidget(
              onPressed: () => Get.to(const ViewScreen()),
              text: "VIEW",
            ),
          ],
        ),
      ),
    );
  }
}
