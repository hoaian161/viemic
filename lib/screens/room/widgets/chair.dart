import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/utils/space.dart';

import '../../../apis/general.dart';

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
    static final Map<int, Map<String, dynamic>> _userCache = {};

    Map<String, dynamic>? user;

    @override
    void initState() {
        super.initState();
        if (_userCache.containsKey(widget.uid)) {
            setState(() {
                user = _userCache[widget.uid];
            });
        } else {
            userInfo();
        }
    }

    Future<void> userInfo() async {
        try {
            var userData = await server("getUserInfo", "userID=${widget.uid}");
            if (userData["data"]?["info"] != null) {
                _userCache[widget.uid] = userData["data"]["info"];
                setState(() {
                    user = _userCache[widget.uid];
                });
            }
        } catch (e) {
            print("Failed to load user data: $e");
        }
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            width: 100,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: user?.containsKey("avatar") ?? false
                            ? Image.network(user!["avatar"], width: 50)
                            : Icon(Icons.person, size: 24),
                    ),
                    SizedBox(height: 8),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Flexible(
                                child: Text(
                                    user?["name"] ?? " ",
                                    style: TextStyle(fontSize: 14),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                ),
                            ),
                            SizedBox(width: MICRO_PADDING),
                            if (user?["badge"] != "" && user?["badge"] != null)
                                Image.asset(
                                    "assets/images/badges/${user?["badge"]}.png",
                                    width: 15
                                ),
                        ],
                    )
                ],
            ),
        );
    }
}
