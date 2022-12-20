import 'package:flutter/material.dart';

import '../components/app_bar_widget.dart';
import '../model/resume_model.dart';

class ViewScreen extends StatefulWidget {
  ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  late List<Resume>? resume = [];

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
      body: Padding(
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
              children: const [
                Text(
                  'Total: 0',
                  style: TextStyle(
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
                  itemCount: resume!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 7,
                      child: ListTile(
                        leading: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            // image:
                            // DecorationImage(
                            //     fit: BoxFit.fill, image: MemoryImage(_bytesImage!)
                            //   // Image.asset(imgConvert(widget.image))
                            //
                            // ),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              " widget.name!",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            // Row(
                            //   children: [Text(widget.gender!), Text(" | ${widget.age}")],
                            // )
                          ],
                        ),
                        subtitle: const Text(
                          "View Resume",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                // ResumeDatabase.instance.delete(widget.id!);
                              });
                            },
                            icon: const Icon(Icons.delete)),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
