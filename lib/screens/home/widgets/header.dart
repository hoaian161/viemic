import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/screens/home/widgets/tabs.dart';
import 'package:viemic/utils/color.dart';
import 'package:viemic/utils/space.dart';

import '../../../components/avatar.dart';
import '../../../components/label.dart';

class Header extends StatefulWidget {
    @override
    State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
    @override
    Widget build(BuildContext context) {
        return Container(
            padding: EdgeInsets.all(DEFAULT_SCREEN_PADDING),
            decoration: BoxDecoration(
                color: BLUE_COLOR,
            ),
            child: Row(
                children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            SubLabel("Xin chào,", FADED_1_COLOR),
                            StrongLabel("VieMic", WHITE_COLOR)
                        ]
                    ),
                    Spacer(),
                    Tabs(),
                ],
            ),
        );
    }
}