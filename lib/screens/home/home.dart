import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/screens/home/widgets/header.dart';
import 'package:viemic/screens/home/widgets/tabs.dart';
import 'package:viemic/utils/color.dart';

import '../../utils/space.dart';
import '../scroller/scroller.dart';

class Home extends StatefulWidget {
    @override
    State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
    @override
    Widget build(BuildContext context) {
        return DefaultTabController(
            length: 3,
            child: Scaffold(
                body: SafeArea(
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                            children: [
                                Header(),
                                SizedBox(height: 30),
                                // Tabs(),
                                Expanded(
                                    child: TabBarView(
                                        children: [
                                            Scroller(),
                                            Center(child: Text("-")),
                                            Center(child: Text("-")),
                                        ],
                                    ),
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}
