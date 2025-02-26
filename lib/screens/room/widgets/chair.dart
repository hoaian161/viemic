import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/utils/color.dart';
import 'package:viemic/utils/space.dart';

import '../../../apis/general.dart';

class Chair extends StatefulWidget {
    final int uid;
    final Map<String, dynamic> userObj;

    const Chair({
        super.key,
        required this.uid,
        required this.userObj
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
                    Stack(
                        alignment: Alignment.center,
                        children: [
                            for (int i = 2; i >= 0; i--)
                                AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: 50 + ((widget.userObj["volume"] as num?)?.toDouble() ?? 0)/50 * (i + 1) * 5,
                                    height: 50 + (((widget.userObj["volume"] as num?)?.toDouble() ?? 0)/50 * (i + 1) * 5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: BLUE_COLOR.withOpacity(0.2 - (i * 0.05)),
                                    ),
                                ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: user?.containsKey("avatar") ?? false
                                    ? Image.network(user!["avatar"], width: 50)
                                    : Icon(Icons.person, size: 24),
                            ),
                            if (widget.userObj["isMute"] == true)
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                        "assets/images/icons/mic_close.png",
                                        width: 50,
                                        color: Colors.black.withOpacity(0.5),
                                        colorBlendMode: BlendMode.dstATop,
                                    ),
                                ),
                        ],
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
                    ),
                ],
            ),
        );
    }
}
