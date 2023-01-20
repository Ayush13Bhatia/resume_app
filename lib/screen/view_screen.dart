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
          title: "View",
          onBackTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
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
            Expanded(
              child: FutureBuilder(
                future: SQLHelper.personQuery(query: _searchController.text),
                builder: (_, AsyncSnapshot<List<Resume>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("ERROR ${snapshot.hasError}"),
                    );
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, bottom: 4.0, right: 10.0),
                        child: Row(
                          children: [
                            const Text('Total:'),
                            const SizedBox(
                              width: 3,
                            ),
                            Text('${snapshot.data!.length}'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, i) {
                            final data = snapshot.data![i];
                            return Column(
                              children: [
                                Card(
                                  elevation: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (data.image == null) {
                                              return;
                                            }
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => EnlargeImage(
                                                  profileImg: '${data.image}',
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: data.image == null
                                                  ? const DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                        'assets/images/dummy.png',
                                                      ),
                                                    )
                                                  : DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: MemoryImage(
                                                        base64Decode(
                                                          '${data.image}',
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${data.name}'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Text("${data.gender}  |"),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text('${data.age}')
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            GestureDetector(
                                              onTap: (data.resumePdf == null)
                                                  ? null
                                                  : () {
                                                      createPdfPath('${data.resumePdf}');
                                                    },
                                              child: Text(
                                                "View Resume",
                                                style: TextStyle(
                                                    color: (data.resumePdf == null) ? MyThemes.grey : MyThemes.primary,
                                                    decoration: TextDecoration.underline),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
