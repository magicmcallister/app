import 'package:app/screen/menu.dart';
import 'package:flutter/material.dart';
import 'package:app/screen/login.dart';
import 'package:app/constant.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
