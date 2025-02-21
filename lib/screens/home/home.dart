import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/components/label.dart';
import 'package:viemic/screens/home/widgets/header.dart';
import 'package:viemic/screens/home/widgets/tabs.dart';
import 'package:viemic/utils/color.dart';

import '../../utils/space.dart';
import '../rooms/rooms.dart';

class Home extends StatefulWidget {
    @override
    State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
    @override
    Widget build(BuildContext context) {
        return DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                    toolbarHeight: 0,
                    // backgroundColor: BLUE_COLOR,
                ),
                body: SafeArea(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Header(),
                            SizedBox(height: 20),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: DEFAULT_SCREEN_PADDING),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        StrongLabel("Rooms", BLACK_COLOR),
                                        SubLabel("Tham gia phòng trò chuyện", FADED_1_COLOR),
                                    ],
                                ),
                            ),
                            // Tabs(),
                            Expanded(
                                child: TabBarView(
                                    children: [
                                        Rooms(),
                                        Center(child: Text("-")),
                                    ],
                                ),
                            ),
                        ],
                    ),
                ),
                // bottomNavigationBar: Container(
                //     height: 100,
                //     child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //             Text("ABC"),
                //             Text("ABC"),
                //         ],
                //     ),
                // )
            ),
        );
    }
}
