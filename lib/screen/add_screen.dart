import 'dart:convert';
import 'dart:ui';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../components/app_bar_widget.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';
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

  convertBaseImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result != null) {
      PlatformFile? files = result.files.first;
      final bytes = await File(files.path ?? "").readAsBytes();
      String img64 = base64Encode(bytes);
      return img64;
    }
    // final image = result.toString();
    // final bytes = await result?.readAsBytes();
  }

  @override
  void initState() {
    // genderController.text = '';
    // skillsController.text = '';
    // resumePdf = '';

    // gender = 'Male';
    // TODO: implement initState
    super.initState();
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
                  return _addItems(
                    Resume(
                      name: nameController.text,
                      currentCTC: currentCTCController.text,
                      expectedCTC: expectedCTCController.text,
                      gender: gender,
                      skils: skill,
                      resumePdf: resumePdf,
                      image: profilePic,
                      // createdTime: DateFormat('dd-MM-yyyy').parse(dobController.text)

                      // createdTime: widget.resume!.createdTime,
                      // DateFormat("dd-MM-yyy").format(Resume()) as DateTime,
                    ),
                  );
                }
                print("Pressed");
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
                Row(
                  children: const [
                    Text("Name"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the text";
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name",
                  ),
                  onChanged: (val) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   children: const [
                //     Text("BOD"),
                //     Text(
                //       "*",
                //       style: TextStyle(color: Colors.red),
                //     ),
                //   ],
                // ),
                // TextFormField(
                //   readOnly: true,
                //   controller: dobController,
                //   decoration: InputDecoration(
                //     suffixIcon: GestureDetector(
                //       onTap: () async {
                //         // ShowDateWidget.showDate(context) as DateTime?;
                //         DateTime? pickedDate = await showDatePicker(
                //             context: context, initialDate: DateTime.now(), firstDate: DateTime(1990), lastDate: DateTime(2025));
                //
                //         String formattedDate = DateFormat("dd-MM-yyy").format(pickedDate!);
                //
                //         dobController.text = formattedDate;
                //       },
                //       child: const Icon(
                //         Icons.calendar_month,
                //       ),
                //     ),
                //     border: const OutlineInputBorder(),
                //     hintText: "DOB",
                //     // labelText:  ,
                //   ),
                //   onChanged: (val) {
                //     setState(() {
                //       // TODO: implement date format changes
                //     });
                //   },
                // ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Text("Gender"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
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
                                    // state.didChange(newValue);

                                    // state.didChange(newValue);
                                  });
                                },
                                items: const [
                                  DropdownMenuItem(value: '1', child: Text('Male')),
                                  DropdownMenuItem(value: '2', child: Text('Female')),
                                ]),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Text("Current CTC"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                TextFormField(
                  controller: currentCTCController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Current CTC",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Text("Expected CTC"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                TextFormField(
                  controller: expectedCTCController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Expected CTC",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Text("Resume"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    String imgBase64 = await convertBaseImage();
                    // pickPDF(resumePdf);
                    print("resume");
                    print(resumePdf);
                    setState(() {
                      resumePdf = imgBase64;
                    });
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    strokeWidth: 1,
                    radius: const Radius.circular(15),
                    // padding: const EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Container(
                        color: Colors.blue[100],
                        height: 100,
                        width: double.infinity,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.upload,
                                size: 60,
                                color: Colors.blue,
                              ),
                              Text("Upload Photo/pdf")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Text("Profile-Pic"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    String abg = await convertBaseImage();
                    setState(() {
                      profilePic = abg;
                    });
                    // print(profilePic);
                    // pickImage(img);
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    strokeWidth: 1,
                    radius: const Radius.circular(15),
                    // padding: const EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        color: Colors.blue[100],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.upload,
                                size: 60,
                                color: Colors.blue,
                              ),
                              Text("Upload Photo")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Text("Skills"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
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
                                    child: Text('Backend Developer'),
                                  ),
                                  DropdownMenuItem(
                                    value: '2',
                                    child: Text('Frontend Developer'),
                                  ),
                                ]),
                          ),
                        );
                      },
                    ),
                  ],
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
