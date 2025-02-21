import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/utils/color.dart';
import 'package:viemic/utils/space.dart';

import '../../../components/badge.dart';
import '../../../components/label.dart';
import '../../../components/thumbnail.dart';
import '../../../utils/internal.dart';
import '../../../utils/modal.dart';
import '../../room/room.dart';

class Item extends StatefulWidget {
    final Map<String, dynamic> room;

    const Item({
        super.key,
        required this.room
    });

    @override
    State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
                if (Internal().get("isJoined") == "") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Room(
                                room: widget.room
                            ),
                        ),
                    );
                } else if (Internal().get("isJoined") == widget.room["id"]) {
                    Navigator.pop(context);
                } else {
                    modal(context, "Bạn cần rời khỏi phòng hiện tại trước khi tham gia phòng khác", AnimationStyles.defaultStyle, 0.20);
                }
            },
            child: Container(
                margin: EdgeInsets.symmetric(vertical: DEFAULT_PADDING),
                child: Row(
                    children: [
                        RoomThumbnail(widget.room["thumbnail"]),
                        SizedBox(width: DEFAULT_PADDING),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                WeightLabel(widget.room["title"], BLACK_COLOR),
                                // SizedBox(height: MICRO_PADDING),
                                Row(
                                    children: [
                                        Icon(Icons.multitrack_audio_outlined),
                                        SizedBox(width: MICRO_PADDING),
                                        SubLabel(widget.room["desc"], FADED_1_COLOR)
                                    ],
                                ),
                            ],
                        ),
                        Spacer(),
                        BlueBadge(
                            Icon(
                                Icons.people_alt_sharp,
                                color: WHITE_COLOR,
                            ),
                            "0",
                        )
                    ],
                ),
            ),
        );
    }
}