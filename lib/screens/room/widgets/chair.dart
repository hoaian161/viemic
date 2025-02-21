import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/components/avatar.dart';
import 'package:viemic/components/label.dart';
import 'package:viemic/utils/space.dart';

import '../../../apis/general.dart';
import '../../../utils/color.dart';
import '../../../utils/size.dart';

class Chair extends StatefulWidget {
    final int uid;

    const Chair({
        super.key,
        required this.uid
    });

    @override
    State<Chair> createState() => _ChairState();
}

class _ChairState extends State<Chair> {
    Map<String, dynamic>? user;

    @override
    void initState() {
        super.initState();
        userInfo();
    }

    Future<void> userInfo() async {
        try {
            var userData = await server("getUserInfo", "userID=${widget.uid}");
            setState(() {
                user = userData["data"]["info"];
            });
        } catch (e) {
            // Handle error
            print("Failed to load user data: $e");
        }
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            width: DEFAULT_AVATAR_SIZE + 40,
            margin: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
            decoration: BoxDecoration(
                // color: Colors.red
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Stack(
                        alignment: Alignment.topCenter,
                        children: [
                            user != null
                                ? DefaultAvatar("${user?["avatar"]}")
                                : const CircularProgressIndicator(),
                            Container(
                                margin: EdgeInsets.only(top: DEFAULT_AVATAR_SIZE + 10),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Flexible(
                                            child: DefaultLabel("${user?["name"]}", BLACK_COLOR),
                                        ),
                                        SizedBox(width: MICRO_PADDING),
                                        user?["badge"] != ""
                                            ? Image.asset(
                                                "assets/images/badges/${user?["badge"]}.png",
                                                width: 18
                                                )
                                            : SizedBox()
                                    ],
                                ),
                            ),
                        ],
                    )
                ],
            ),
        );
    }
}