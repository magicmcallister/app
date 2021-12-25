import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:app/constant.dart';
import 'package:app/screen/menu.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _dateTime = DateTime.now();

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
    TextEditingController taskTitle = new TextEditingController();
    TextEditingController taskDescription = new TextEditingController();

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
                child: Text(
                  "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}",
                  style: TextStyle(fontSize: 20),
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
                        initialDate: _dateTime,
                        firstDate: DateTime(2015),
                        lastDate: DateTime(2050));
                    if (_newDate != null) {
                      setState(() {
                        _dateTime = _newDate;
                      });
                    }
                  },
                  child: const Text('Select date'),
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor, fixedSize: Size(350, 60))),
              Expanded(child: SizedBox()),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          print(taskTitle.text);
                          print(taskDescription.text);
                        } else {}
                      }
                    },
                    child: const Text('Submit'),
                    style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor, fixedSize: Size(100, 50))),
              )
            ],
          ),
        ));
  }
}
