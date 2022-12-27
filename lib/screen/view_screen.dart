import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/sql_helper.dart';

import '../components/app_bar_widget.dart';
import '../model/resume_model.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  Future<List<Resume>> getResume() async {
    return await SQLHelper.personQuery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBarWidget(
          title: "View Screen",
          onBackTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<Resume>>(
        future: getResume(),
        builder: (_, AsyncSnapshot<List<Resume>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Card(
                            elevation: 0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(9)),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    // width: 5.0,
                                  ),
                                ),
                                suffixIcon: Icon(Icons.search),
                                hintText: 'Search',
                                filled: true,
                                errorStyle: TextStyle(fontSize: 10),
                              ),
                              onChanged: (value) {
                                value = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a search term';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Total: ',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        "${snapshot.data!.length}",
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data![index];
                        return Card(
                          elevation: 7,
                          child: ListTile(
                            leading: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: MemoryImage(
                                      base64Decode(
                                        "${data.image}",
                                      ),
                                    )
                                    // Image.asset(imgConvert(widget.image))
                                    ),
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data.name}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: const Text(
                              // DateFormat("dd/MM/yyyy").format(data.createdTime ?? DateTime.now()),
                              "View Resume",
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    SQLHelper.deleteItem(int.parse('${snapshot.data![index].id}'));
                                  });
                                },
                                icon: const Icon(Icons.delete)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
