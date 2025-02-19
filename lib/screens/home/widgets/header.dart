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
        return Row(
            children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        SubLabel("Xin chào,"),
                        StrongLabel("VieMic")
                    ]
                ),
                Spacer(),
                Tabs()
                // Spacer(),
                // Container(
                //     padding: EdgeInsets.all(SMALL_PADDING),
                //     decoration: BoxDecoration(
                //         color: FADED_BACKGROUND_COLOR,
                //         borderRadius: BorderRadius.circular(50),
                //     ),
                //     child: Row(
                //         children: [
                //             DefaultAvatar("https://robohash.org/set_set3/bgset_bg1/Phong1"),
                //             SizedBox(width: SMALL_PADDING),
                //             DefaultLabel("hoaian"),
                //             SizedBox(width: SMALL_PADDING),
                //         ],
                //     ),
                // ),
            ],
        );
    }
}