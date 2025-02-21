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
        return Column(
            children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        SizedBox(height: 10),
                        SubLabel("Xin chào,", FADED_1_COLOR),
                        StrongLabel("VieMic", BLACK_COLOR),
                        SizedBox(height: 20),
                    ],
                ),
                Container(
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                                BLUE_COLOR,
                                WHITE_COLOR,
                            ],
                        ),
                    ),
                    child: Row(
                        children: [
                            Spacer(),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                    SubLabel("Rất vui khi được gặp bạn", FADED_3_COLOR),
                                    WeightLabel("- Tahu -", WHITE_COLOR),
                                ],
                            ),
                            SizedBox(width: DEFAULT_PADDING),
                            Image.asset(
                                "assets/icons/square.png",
                                width: 80,
                            ),
                        ],
                    )
                ),
            ],
        );
        // return Container(
        //     padding: EdgeInsets.all(DEFAULT_SCREEN_PADDING),
        //     decoration: BoxDecoration(
        //         // gradient: LinearGradient(
        //         //     begin: Alignment.topCenter,
        //         //     end: Alignment.bottomCenter,
        //         //     colors: [
        //         //         // BLUE_COLOR,
        //         //         Color.fromRGBO(9, 95, 232, 1),
        //         //         Color.fromRGBO(9, 95, 232, 0.7),
        //         //         WHITE_COLOR
        //         //     ],
        //         // ),
        //         color: BLUE_COLOR,
        //         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
        //     ),
        //     child: Row(
        //         children: [
        //             Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                     SubLabel("Xin chào,", FADED_3_COLOR),
        //                     StrongLabel("VieMic", WHITE_COLOR)
        //                 ]
        //             ),
        //             Spacer(),
        //             Container(
        //                 decoration: BoxDecoration(
        //                     color: Colors.blueAccent[400],
        //                     borderRadius: BorderRadius.circular(50),
        //                 ),
        //                 child: Row(
        //                     children: [
        //                         ClipRRect(
        //                             child: Image.asset(
        //                                 "assets/icons/head.png",
        //                                 width: 50
        //                             ),
        //                         ),
        //                         SizedBox(width: MICRO_PADDING),
        //                         DefaultLabel("hoaian", WHITE_COLOR),
        //                         SizedBox(width: DEFAULT_PADDING),
        //                     ],
        //                 ),
        //             )
        //             // Tabs(),
        //         ],
        //     ),
        // );
    }
}