import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resume_app1/utils/my_themes.dart';
import '../components/enlarge_image.dart';
import '../db/sql_helper.dart';

import '../components/app_bar_widget.dart';
import '../model/resume_model.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  String? searchText;

  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Future<String> createPdfPath(String pdfFile) async {
    var decodedPdf = base64Decode(pdfFile);
    final output = (await getApplicationDocumentsDirectory()).path;
    final file = File("${output}" + DateTime.now().millisecondsSinceEpoch.toString() + '.pdf');
    await file.writeAsBytes(decodedPdf.buffer.asUint8List());

    await OpenFilex.open(file.path);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBarWidget(
          title: "View Screen",
          onBackTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 70,
              width: double.maxFinite,
              child: Card(
                elevation: 0,
                color: MyThemes.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: TextFormField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                      borderSide: BorderSide(
                        color: MyThemes.grey,
                        // width: 5.0,
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: MyThemes.black,
                    ),
                    hintText: 'Search',
                    filled: true,
                    errorStyle: TextStyle(fontSize: 10),
                  ),
                  onChanged: (value) {
                    searchText = value;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a search term';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Resume>>(
              future: SQLHelper.personQuery(query: _searchController.text),
              builder: (_, AsyncSnapshot<List<Resume>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("ERROR ${snapshot.error}"),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
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
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data![index];
                            return Card(
                              elevation: 7,
                              child: ListTile(
                                leading: GestureDetector(
                                  onTap: () {
                                    print("Object11");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EnlargeImage(
                                          profileImg: data.image,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: MemoryImage(
                                          base64Decode("${data.image}"),
                                        ),
                                      ),
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
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('${data.gender}'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text("${data.age}"),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (data.resumePdf!.isEmpty && data.resumePdf == null) {
                                          return;
                                        }
                                        createPdfPath("${data.resumePdf}");
                                      },
                                      child: const Text(
                                        "View Resume",
                                        style: TextStyle(
                                          color: MyThemes.primary,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      SQLHelper.deleteItem(int.parse('${snapshot.data![index].id}'));
                                    });
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
