import 'package:app/constant.dart';
import 'package:app/screen/menu.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<Login> {
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/wall.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
              padding: EdgeInsets.fromLTRB(20, size.height / 2.0 - 40, 20, 0),
              child: Center(
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: kPrimaryColor,
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kPrimaryColor, width: 2.0),
                          ),
                          labelStyle:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                          labelText: 'token',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock,
                              color: Colors.black.withOpacity(0.6)),
                          // suffixIcon: Icon(Icons.remove_red_eye,
                          //     color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 60,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: kPrimaryColor),
                          child: Text('login'),
                          onPressed: () {
                            if (token == passwordController.text) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MenuScreen()));
                            } else {
                              passwordController.text = "";
                            }
                          },
                        )),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
