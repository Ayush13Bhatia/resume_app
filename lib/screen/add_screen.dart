import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:resume_app1/components/elevation_button_widget.dart';
import 'package:resume_app1/utils/my_themes.dart';

import '../components/app_bar_widget.dart';

import 'package:intl/intl.dart';
import '../components/border_dotted.dart';
import '../components/drop_down_widget.dart';
import '../components/text_form_widget.dart';
import '../components/show_date_widget.dart';
import '../components/star_form_widget.dart';
import '../controller/logics.dart';
import '../db/sql_helper.dart';

import '../model/resume_model.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key, this.resume}) : super(key: key);
  final Resume? resume;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController currentCTCController = TextEditingController();
  TextEditingController expectedCTCController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController skillsController = TextEditingController();

  void _addItems(Resume resume) async {
    await SQLHelper.insertPerson(resume);
  }

  String? gender;
  String? skill;
  String? resumePdf;
  String? profilePic;
  String? image1;

  List<String> dropList = ['Male', 'Female'];
  List<String> dropList1 = ['Frontend Developer', 'Backend Developer'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBarWidget(
          actions: [
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  int myCurrentYear = DateFormat("dd-MM-yyyy").parse(dobController.text).year;
                  return _addItems(
                    Resume(
                      name: nameController.text,
                      currentCTC: currentCTCController.text,
                      expectedCTC: expectedCTCController.text,
                      gender: gender,
                      skils: skill,
                      resumePdf: resumePdf,
                      image: profilePic,
                      createdTime: DateFormat('dd-MM-yyyy').parse(dobController.text),
                      age: int.parse((DateTime.now().year - myCurrentYear).toString()),
                    ),
                  );
                }
              },
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            )
          ],
          title: "Add Screen",
          onBackTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Please provde the following information"),
                const SizedBox(
                  height: 10,
                ),
                TextFormWidget(
                  controller: nameController,
                  name: "Name",
                ),
                const StarFormWidget(
                  name: "DOB",
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  readOnly: true,
                  controller: dobController,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        DateTime? d = await ShowResumeDateWidget.showDate(context);
                        String formattedDate = DateFormat("dd-MM-yyy").format(d!);
                        dobController.text = formattedDate;
                      },
                      child: const Icon(
                        Icons.calendar_today,
                        color: MyThemes.primary,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    hintText: "DOB",
                    // labelText:  ,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const StarFormWidget(
                  name: "Gender",
                ),
                const SizedBox(
                  height: 10,
                ),
                DropDownWidget(
                  value: gender,
                  // hintText: 'Select gender',
                  textValue: 'Select gender',
                  onChange: (newValue) {
                    setState(() {
                      gender = newValue!;
                    });
                  },
                  dropList: dropList,
                ),
                TextFormWidget(
                  name: "CurrentCTC",
                  controller: currentCTCController,
                ),
                TextFormWidget(
                  controller: expectedCTCController,
                  name: "Expected CTC",
                ),
                const SizedBox(
                  height: 10,
                ),
                const StarFormWidget(name: "Resume"),
                const SizedBox(
                  height: 5,
                ),
                BorderDotted(
                  borderName: "Upload PDF",
                  onTap: () async {
                    String profileImg = await Logics().convertBaseImage(['pdf']);
                    setState(() {
                      resumePdf = profileImg;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const StarFormWidget(name: "Profile-Pic"),
                const SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: profilePic != null,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Image(
                          image: MemoryImage(
                            base64Decode(
                              profilePic.toString(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onTap: () {
                          setState(() {
                            profilePic = null;
                          });
                        },
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: profilePic == null,
                  child: BorderDotted(
                    borderName: "Upload Photo",
                    onTap: () async {
                      String profileImg = await Logics().convertBaseImage(['jpg', 'png']);
                      setState(() {
                        profilePic = profileImg;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const StarFormWidget(name: "Skills"),
                const SizedBox(
                  height: 5,
                ),
                DropDownWidget(
                  value: skill,
                  hintText: 'Skills',
                  textValue: 'Skills',
                  onChange: (newValue) {
                    skill = newValue!;
                    setState(() {});
                  },
                  dropList: dropList1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevationButtonWidget(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          int myCurrentYear = DateFormat("dd-MM-yyyy").parse(dobController.text).year;
                          return _addItems(
                            Resume(
                              name: nameController.text,
                              currentCTC: currentCTCController.text,
                              expectedCTC: expectedCTCController.text,
                              gender: gender,
                              skils: skill,
                              resumePdf: resumePdf,
                              image: profilePic,
                              createdTime: DateFormat('dd-MM-yyyy').parse(dobController.text),
                              age: int.parse((DateTime.now().year - myCurrentYear).toString()),
                            ),
                          );
                        }
                      },
                      padding: const EdgeInsets.all(1.5),
                      showIcon: false,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
