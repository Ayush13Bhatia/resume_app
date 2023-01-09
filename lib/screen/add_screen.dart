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
import '../components/resume_text_form_widget.dart';
import '../components/show_date_widget.dart';
import '../components/star_form_widget.dart';
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

  convertBaseImage(List<String> extensions) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );
    if (result != null) {
      PlatformFile? files = result.files.first;
      final bytes = await File(files.path ?? "").readAsBytes();
      String img64 = base64Encode(bytes);
      return img64;
    }
  }

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
                // Column(
                //   children: [
                //     FormField(
                //       builder: (FormFieldState state) {
                //         return InputDecorator(
                //           decoration: InputDecoration(
                //               errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                //               hintText: 'Please select expense',
                //               border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                //           // isEmpty: gender == '',
                //           child: DropdownButtonHideUnderline(
                //             child: DropdownButton<String>(
                //               hint: const Text("Select gender"),
                //               value: gender,
                //               isDense: true,
                //               onChanged: (newValue) {
                //                 setState(() {
                //                   gender = newValue!;
                //                 });
                //               },
                //               items: const [
                //                 DropdownMenuItem(value: 'Male', child: Text('Male')),
                //                 DropdownMenuItem(value: 'Female', child: Text('Female')),
                //               ],
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   ],
                // ),
                // Column(
                //   children: [
                //     FormField(
                //       builder: (FormFieldState state) {
                //         return InputDecorator(
                //           decoration: InputDecoration(
                //               errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                //               hintText: 'Please select expense',
                //               border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                //           // isEmpty: gender == '',
                //           child: DropdownButtonHideUnderline(
                //             child: DropdownButton<String>(
                //               hint: const Text("Select gender"),
                //               value: gender,
                //               isDense: true,
                //               onChanged: (newValue) {
                //                 setState(() {
                //                   gender = newValue!;
                //                 });
                //               },
                //               items: const [
                //                 DropdownMenuItem(value: 'Male', child: Text('Male')),
                //                 DropdownMenuItem(value: 'Female', child: Text('Female')),
                //               ],
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   ],
                // ),
                Column(
                  children: [
                    FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                              hintText: 'Please select expense',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                          // isEmpty: gender == '',
                          child: DropdownButtonHideUnderline(
                            child: DropDownWidget(
                              value: gender,
                              hintText: 'Select gender',
                              textValue: 'Select gender',
                              onChange: (newValue) {
                                setState(() {
                                  gender = newValue!;
                                });
                              },
                              dropList: dropList,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
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
                    String profileImg = await convertBaseImage(['pdf']);
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
                BorderDotted(
                  borderName: "Upload Photo",
                  onTap: () async {
                    String profileImg = await convertBaseImage(['jpg', 'png']);
                    setState(() {
                      profilePic = profileImg;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const StarFormWidget(name: "Skills"),
                const SizedBox(
                  height: 5,
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.stretch,
                //   children: [
                //     FormField(
                //       builder: (FormFieldState state) {
                //         return InputDecorator(
                //           decoration: InputDecoration(
                //               errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                //               hintText: 'Please select expense',
                //               border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                //           // isEmpty: skill == '',
                //           child: DropdownButtonHideUnderline(
                //             child: DropdownButton<String>(
                //               hint: const Text("Skills"),
                //               value: skill,
                //               isDense: true,
                //               onChanged: (newValue) {
                //                 setState(() {
                //                   skill = newValue;
                //                   // state.didChange(newValue);
                //                 });
                //               },
                //               items: const [
                //                 DropdownMenuItem(
                //                   value: 'Frontend Developer',
                //                   child: Text('Frontend Developer'),
                //                 ),
                //                 DropdownMenuItem(
                //                   value: 'Backend Developer',
                //                   child: Text('Backend Developer'),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   ],
                // ),
                Column(
                  children: [
                    FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                              hintText: 'Please select expense',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                          // isEmpty: gender == '',
                          child: DropdownButtonHideUnderline(
                            child: DropDownWidget(
                              value: skill,
                              hintText: 'Skills',
                              textValue: 'Skills',
                              onChange: (newValue) {
                                skill = newValue!;
                                setState(() {});
                              },
                              dropList: dropList1,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                // Column(
                //   children: [
                //     FormField(
                //       builder: (FormFieldState state) {
                //         return InputDecorator(
                //           decoration: InputDecoration(
                //               errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                //               hintText: 'Please select expense',
                //               border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                //           // isEmpty: gender == '',
                //           child: DropdownButtonHideUnderline(
                //             child: DropDownWidget(
                //               value: skill,
                //               hintText: 'Skills',
                //               textValue: 'Skills',
                //               onChange: (newValue) {
                //                 setState(() {
                //                   skill = newValue!;
                //                 });
                //               },
                //               dropList: dropList1,
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   ],
                // ),
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
