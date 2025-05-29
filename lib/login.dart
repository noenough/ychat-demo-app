import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_ychat_desktop/home.dart';
import 'package:project_ychat_desktop/withapi/cn.dart';
import 'package:project_ychat_desktop/ychat_widget.dart';

String username = "";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 550,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/images/ychat_board.png"),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(child: LoginArea()),
          ],
        ),
      ),
    );
  }
}

class LoginArea extends StatefulWidget {
  const LoginArea({super.key});

  @override
  State<LoginArea> createState() => _LoginAreaState();
}

class _LoginAreaState extends State<LoginArea> {
  TextEditingController user = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            border: Border.all(color: maingreen),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(3),
            child: TextField(
              controller: user,
              decoration: InputDecoration(
                hintText: "Nick",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(maingreen),
            fixedSize: WidgetStatePropertyAll(
              Size(MediaQuery.of(context).size.width / 2, 50),
            ),
          ),
          onPressed: () {
            setState(() {
              username = user.text;
            });

            ws.sink.add("$username  ->");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home(username)),
            );
          },
          child: Text("Login"),
        ),
      ],
    );
  }
}
