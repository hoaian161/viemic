import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/components/avatar.dart';
import 'package:viemic/components/label.dart';
import 'package:viemic/utils/space.dart';

import '../../../apis/general.dart';
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
            width: DEFAULT_AVATAR_SIZE + 20,
            margin: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Stack(
                        alignment: Alignment.topCenter,
                        children: [
                            user != null ? DefaultAvatar("${user?["avatar"]}") : const CircularProgressIndicator(),
                            Container(
                                margin: EdgeInsets.only(top: DEFAULT_AVATAR_SIZE + 10),
                                child: DefaultLabel("${user?["name"]}"),
                            ),
                        ],
                    )
                ],
            ),
        );
    }
}