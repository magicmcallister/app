import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:app/constant.dart';
import 'package:app/screen/menu.dart';
import 'package:app/client/notion.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _formKey = GlobalKey<FormState>();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  var _dateTime;

  bool isLoading = false;
  late Map newTaskData;
  String dateText = "No hay fecha";

  TextEditingController taskTitle = new TextEditingController();
  TextEditingController taskDescription = new TextEditingController();

  postTask() async {
    setState(() {
      isLoading = true;
    });
    var taskBody = json.encode(newTaskData);
    print(taskBody);
    var response = await http.post(Uri.parse(postTaskUrl),
        headers: headers, body: taskBody);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
    } else {
      isLoading = false;
    }
  }

  Future _postTask() async {
    postTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New task"),
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MenuScreen(
                          reloadData: false,
                        )));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black.withOpacity(0.7),
          ),
          iconSize: 25.0,
        ),
      ),
      body: buildForm(),
    );
  }

  Widget buildForm() {
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                cursorColor: kPrimaryColor,
                controller: taskTitle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                    ),
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                    labelText: 'Title',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: kPrimaryColor,
                controller: taskDescription,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                  ),
                  labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  // suffixIcon: Icon(Icons.remove_red_eye,
                  //     color: Colors.black.withOpacity(0.6)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: (_dateTime == null)
                    ? Text("No hay fecha", style: TextStyle(fontSize: 20),)
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                              ),
                              onPressed: () {
                                _dateTime = null;
                                setState(() {
                                  dateText = "No hay fecha";
                                });
                              },
                              child: Text(
                                dateText,
                              style: TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                decoration: BoxDecoration(),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    DateTime? _newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015),
                        lastDate: DateTime(2050),
                        builder: (context, child) {
                          return Theme(data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: kPrimaryColor, // header background color
                              onPrimary: Colors.black, // header text color
                              onSurface: Colors.black, // body text color
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                primary: kPrimaryColor, // button text color
                              ),
                            ),
                          ), child: child!)
                        });
                    if (_newDate != null) {
                      setState(() {
                        _dateTime = _newDate;
                        setState(() {
                                 dateText = "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}";
                                });
                      });
                    }
                  },
                  child: const Text('Select date'),
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,  fixedSize: Size(200, 40))),
              Expanded(child: SizedBox()),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          if (_dateTime != null)
                          {
                            newTaskData = {
                            "parent": {
                              "database_id": "3afff078e210449d9fc9d49da2d3711d"
                            },
                            "properties": {
                              "name": {
                                "title": [
                                  {
                                    "text": {"content": taskTitle.text}
                                  }
                                ]
                              },
                              "description": {
                                "rich_text": [
                                  {
                                    "type": "text",
                                    "text": {"content": taskDescription.text}
                                  }
                                ]
                              },
                              "date": {
                                "date": {
                                  "start": dateFormat.format(_dateTime)
                                }
                              }
                            }
                          };
                          }
                          else {
                            newTaskData = {
                            "parent": {
                              "database_id": "3afff078e210449d9fc9d49da2d3711d"
                            },
                            "properties": {
                              "name": {
                                "title": [
                                  {
                                    "text": {"content": taskTitle.text}
                                  }
                                ]
                              },
                              "description": {
                                "rich_text": [
                                  {
                                    "type": "text",
                                    "text": {"content": taskDescription.text}
                                  }
                                ]
                              },
                            }
                          };
                          }
                          _postTask();
                          Future.delayed(Duration(milliseconds: 400), () {
                            // 5 seconds over, navigate to Menu.
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuScreen(
                                          reloadData: true,
                                        )));
                          });
                        } else {}
                      }
                    },
                    child: const Text('Submit'),
                    style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor, fixedSize: Size(100, 40))),
              )
            ],
          ),
        ));
  }
}
