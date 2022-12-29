import 'dart:convert';
import 'dart:ui';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../components/app_bar_widget.dart';

import 'package:dotted_border/dotted_border.dart';
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
                        Icons.calendar_month,
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
                            child: DropdownButton<String>(
                              hint: const Text("Select gender"),
                              value: gender,
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  gender = newValue!;
                                });
                              },
                              items: const [
                                DropdownMenuItem(value: '1', child: Text('Male')),
                                DropdownMenuItem(value: '2', child: Text('Female')),
                              ],
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
                    String profileImg = await convertBaseImage([
                      'pdf',
                    ]);
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                              hintText: 'Please select expense',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                          // isEmpty: skill == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: const Text("Skills"),
                              value: skill,
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  skill = newValue;
                                  // state.didChange(newValue);
                                });
                              },
                              items: const [
                                DropdownMenuItem(
                                  value: '1',
                                  child: Text('Frontend Developer'),
                                ),
                                DropdownMenuItem(
                                  value: '2',
                                  child: Text('Backend Developer'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          return _addItems(Resume());
                        }
                      },
                      child: const Text(
                        'add',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
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
