import 'package:flutter/material.dart';
import 'dart:ui';

class CustomListView extends StatefulWidget {
  const CustomListView({Key? key}) : super(key: key);

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  final controller = TextEditingController();
  final List<String> allStudentList = [
    "Karthik",
    "Rajkamal",
    "Rajkumar",
    "Arjun",
  ];
  String query = '';
  late List<String> studentList;

  @override
  void initState() {
    super.initState();

    studentList = allStudentList;
  }

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    // final style = controller.isEmpty ? styleHint : styleActive;
    return Scaffold(
        appBar: AppBar(
          title: Text("List view with Search Filter"),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black26, width: 2)),
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        String sample = controller.text;
                        print(value);
                        print("value changed $sample");
                        searchStudent(value);
                      },
                      decoration: InputDecoration(
                          suffixIcon: controller.text.isNotEmpty
                              ? GestureDetector(
                                  child: Icon(Icons.close),
                                  onTap: () {
                                    print("clear ");
                                    controller.clear();
                                    searchStudent(controller.text);
                                  },
                                )
                              : null,
                          icon: Icon(
                            Icons.search,
                            color: Colors.black26,
                          )),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: studentList.length,
                        itemBuilder: (context, items) {
                          return Card(
                            color: Colors.lightBlueAccent,
                            child: ListTile(
                              leading: Icon(
                                Icons.person,
                              ),
                              title: Text(studentList[items]),
                              subtitle: Text("student"),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                              ),
                            ),
                          );
                        }))
              ],
            ),
          ),
        ));
  }

  void searchStudent(String query) {
    final studentList = allStudentList.where((element) {
      final searchText = query.toLowerCase();
      final itemValue = element.toLowerCase();

      return itemValue.contains(searchText);
    }).toList();
    setState(() {
      this.query = query;
      this.studentList = studentList;
    });
  }
}
