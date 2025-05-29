import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:project_ychat_desktop/login.dart';
import 'package:project_ychat_desktop/main.dart';
import 'package:project_ychat_desktop/withapi/cn.dart';

import 'package:project_ychat_desktop/ychat_widget.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final cnw = null;
List<String> names = [];
List mesaj = [];
List cur = [];
final GKey = GlobalKey();
WebSocketChannel ws = WebSocketChannel.connect(
  Uri.parse("ws://192.168.31.116:5000/"),
);
Stream<dynamic> wsbrc = ws.stream.asBroadcastStream();

class Home extends StatefulWidget {
  final String username;
  const Home(this.username, {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.username.isEmpty)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
    });
  }

  @override
  void dispose() {
    super.dispose();
    ws.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: MyAppBar()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                decoration: Decorations.bordercontainer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 15,
                      child: Column(
                        children: [
                          StreamBuilder(
                            stream: wsbrc,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                mesaj.insert(0, snapshot.data);
                                cur.insert(0, true);
                                String nad = mesaj[mesaj.length - 1];
                                String vad = nad.substring(0, nad.indexOf(' '));
                                if (names.indexOf(vad) != -1)
                                  cur[0] = false;
                                else {
                                  cur[0] = true;
                                  names.insert(0, vad);
                                }
                              }
                              return Flexible(
                                child: ListView.builder(
                                  reverse: true,
                                  itemCount: mesaj.length,
                                  itemBuilder: (context, index) {
                                    String sms = mesaj[index];
                                    String ad = sms.substring(
                                      0,
                                      sms.indexOf(' '),
                                    );

                                    return mesBox(
                                      ad,
                                      sms,
                                      ad == widget.username,
                                      cur[index],
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          SendMessages(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class mesBox extends StatelessWidget {
  final String nick;
  final String msg;
  final bool sag;
  final bool cur;
  const mesBox(this.nick, this.msg, this.sag, this.cur);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return (cur)
            ? Text("Joined $nick",style: TextStyle(color: Colors.red), textAlign: TextAlign.center)
            : Align(
              alignment: (sag) ? Alignment(1, 0) : Alignment(-1, 0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 2,
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment:
                        (!sag)
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(5),
                        decoration:
                            (!sag)
                                ? BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [BoxShadow(blurRadius: 5)],
                                )
                                : BoxDecoration(
                                  color: maingreen,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [BoxShadow(blurRadius: 5)],
                                ),

                        child: Text(msg.substring(msg.indexOf(" ") + 1)),
                      ),
                      CircleAvatar(child: Text(nick[0]), radius: 15),
                    ],
                  ),
                ),
              ),
            );
      },
    );
  }
}
