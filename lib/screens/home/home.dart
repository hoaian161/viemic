import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                body: SafeArea(
                    child: Column(
                        children: [
                            Header(),
                            SizedBox(height: 10),
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
            ),
        );
    }
}
