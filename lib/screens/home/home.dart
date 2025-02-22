import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/screens/home/widgets/infomation.dart';
import 'package:viemic/screens/home/widgets/features.dart';
import 'package:viemic/screens/home/widgets/header.dart';
import 'package:viemic/screens/home/widgets/news.dart';
import 'package:viemic/screens/home/widgets/rooms.dart';

import '../../utils/theme.dart';

class Home extends StatefulWidget {
    @override
    State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    Widget build(BuildContext context) {
        return MaterialApp(
            theme: DefaultTheme(),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                    child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Header(),
                                SizedBox(height: 16),
                                Infomation(),
                                SizedBox(height: 16),
                                News(),
                                SizedBox(height: 30),
                                Features(),
                                SizedBox(height: 5),
                                Rooms(),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}