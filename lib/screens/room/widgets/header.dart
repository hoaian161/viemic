import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/screens/home/widgets/tabs.dart';
import 'package:viemic/utils/color.dart';
import 'package:viemic/utils/space.dart';

import '../../../components/avatar.dart';
import '../../../components/label.dart';

class Header extends StatefulWidget {
    final Map<String, dynamic> room;

    const Header({
        super.key,
        required this.room
    });

    @override
    State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
    @override
    Widget build(BuildContext context) {
        return Row(
            children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        StrongLabel("${widget.room["title"]}", WHITE_COLOR),
                        SubLabel("${widget.room["desc"]}", FADED_1_COLOR),
                    ]
                ),
                Spacer(),
            ],
        );
    }
}