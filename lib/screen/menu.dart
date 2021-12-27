import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app/constant.dart';
import 'package:app/screen/login.dart';
import 'package:app/screen/task.dart';

import 'package:app/client/notion.dart';
import 'package:app/model.dart';

List databaseTasks = [];

class MenuScreen extends StatefulWidget {
  final bool reloadData;
  const MenuScreen({Key? key, this.reloadData = true}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.reloadData) {
      this.fetchTasks();
    }
  }

  fetchTasks() async {
    setState(() {
      isLoading = true;
    });
    var response = await http.post(Uri.parse(queryDatabaseUrl),
        headers: headers, body: body);
    if (response.statusCode == 200) {
      var taskItems = json.decode(response.body)["results"];
      setState(() {
        databaseTasks = taskItems;
        isLoading = false;
      });
    } else {
      isLoading = false;
    }
  }

  Future _refreshPage() async {
    fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black.withOpacity(0.7),
            ),
            iconSize: 25.0,
          ),
          actions: [
            IconButton(
              onPressed: () {
                print("new task");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TaskScreen()));
              },
              icon: Icon(
                Icons.add_circle_outline_outlined,
                color: Colors.black.withOpacity(0.7),
              ),
              iconSize: 25.0,
            )
          ],
        ),
        body: RefreshIndicator(
            color: kPrimaryColor,
            onRefresh: _refreshPage,
            child: getListView()));
  }

  Widget getListView() {
    if (databaseTasks.contains(null) || databaseTasks.length < 0 || isLoading) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
      ));
    }
    return ListView.builder(
        itemCount: databaseTasks.length,
        itemBuilder: (context, index) {
          return getTaskListView(databaseTasks[index]);
        });
  }

  Widget getTaskListView(task) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        title: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(60 / 2)),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task["properties"]["name"]["title"][0]["plain_text"]
                      .toString(),
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  task["properties"]["description"]["rich_text"][0]
                          ["plain_text"]
                      .toString(),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: Text(
            //     task["properties"]["date"]["date"]["start"].toString(),
            //     style: TextStyle(fontSize: 14),
            //   ),
            // )
          ],
        ),
      ),
    ));
  }
}
