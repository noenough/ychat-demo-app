import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_ychat_desktop/home.dart';
import 'package:project_ychat_desktop/login.dart';
import 'package:project_ychat_desktop/withapi/cn.dart';

Color maingreen = const Color.fromARGB(255, 78, 146, 1);
TextEditingController addusercontroller = TextEditingController();
TextEditingController sendMessagesController = TextEditingController();

class SendMessages extends StatefulWidget {
  const SendMessages({super.key});

  @override
  State<SendMessages> createState() => _SendMessagesState();
}

class _SendMessagesState extends State<SendMessages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: maingreen),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: TextField(
                    controller: sendMessagesController,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                String s = sendMessagesController.text;
                String q = s.replaceAll('"', "'");
                ws.sink.add("$username $q");
                sendMessagesController.clear();
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: Decorations.bordericon,
                child: Center(
                  child: Icon(size: 20, Icons.send_rounded, color: maingreen),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Decorations {
  static Decoration bordercontainer = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: maingreen),
  );
  static Decoration bordericon = BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: maingreen),
  );
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Ychat"),
        IconButton(
          color: maingreen,
          onPressed: () {
            getData();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(title: Text("Add"), actions: [AddUser()]);
              },
            );
          },
          icon: Icon(Icons.add_circle_outlined),
        ),
      ],
    );
  }
}

class TheUser extends StatelessWidget {
  final String ad;
  const TheUser({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: FittedBox(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: maingreen),
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text(ad[0].toUpperCase())),
              ),
            ),
          ),
          SizedBox(width: 5),
          Flexible(child: Text(ad, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: maingreen),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(3),
            child: TextField(
              controller: addusercontroller,
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
            fixedSize: WidgetStatePropertyAll(Size(300, 50)),
          ),
          onPressed: () {},
          child: Text("Add User"),
        ),
      ],
    );
  }
}
