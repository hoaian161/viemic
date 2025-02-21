import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/screens/home/widgets/tabs.dart';
import 'package:viemic/utils/color.dart';
import 'package:viemic/utils/space.dart';

import '../../../components/avatar.dart';
import '../../../components/label.dart';
import '../../home/home.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        StrongLabel("${widget.room["title"]}", BLACK_COLOR),
                        SubLabel("${widget.room["desc"]}", FADED_1_COLOR),
                    ]
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
                        width: 45,
                    ),
                ),
            ],
        );
    }
}