import 'package:flutter/material.dart';
import 'package:project_ychat_desktop/login.dart';

String username = "";
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark(),
      home: Login(),
    );
  }
}
