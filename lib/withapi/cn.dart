import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_ychat_desktop/home.dart';

getData() async {
  var url = Uri.parse("http://192.168.31.116:8000/");
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jdata = jsonDecode(response.body);
    
  } else {
    throw ["Yalnyslyk yuze cykdy: ${response.statusCode}"];
  }
}

