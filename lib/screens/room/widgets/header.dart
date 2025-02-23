import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/internal.dart';
import '../../../utils/space.dart';
import '../../home/home.dart';

Map<String, dynamic> user = Internal().get("user");

class Header extends StatefulWidget {
    final Map<String, dynamic> room;
    final Future<void> Function(String) kickMessage;

    const Header({
        super.key,
        required this.room,
        required this.kickMessage
    });

    @override
    State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
    @override
    Widget build(BuildContext context) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                            "${widget.room["title"]}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                            ),
                        ),
                        Text(
                            "${widget.room["desc"]}",
                            style: TextStyle(color: Colors.grey),
                        ),
                    ],
                ),
                Spacer(),
                InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(),
                            ),
                        );
                    },
                    child: Image.asset(
                        "assets/images/icons/minimize.png",
                        width: 35,
                    ),
                ),
                SizedBox(width: SMALL_PADDING),
                InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                        widget.kickMessage("Bạn đã rời phòng");
                    },
                    child: Image.asset(
                        "assets/images/icons/quit.png",
                        width: 35,
                    ),
                ),
            ],
        );
    }
}