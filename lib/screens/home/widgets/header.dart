import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/utils/color.dart';

import '../../../utils/internal.dart';

Map<String, dynamic> user = Internal().get("user");

class Header extends StatefulWidget {
    @override
    State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
    @override
    Widget build(BuildContext context) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                CircleAvatar(
                    radius: 30,
                    backgroundColor: FADED_2_COLOR,
                    backgroundImage: NetworkImage("${user["avatar"]}"),
                ),
                SizedBox(width: 16),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                            "Xin chào,",
                            style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                            "${user["name"]}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                            ),
                        ),
                    ],
                ),
            ],
        );
    }
}