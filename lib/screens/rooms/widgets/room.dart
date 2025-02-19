import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/utils/color.dart';
import 'package:viemic/utils/space.dart';

import '../../../components/badge.dart';
import '../../../components/label.dart';
import '../../../components/thumbnail.dart';

class Room extends StatefulWidget {
    final Map<String, dynamic> room;

    const Room({
        super.key,
        required this.room
    });

    @override
    State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.symmetric(vertical: DEFAULT_PADDING),
            child: Row(
                children: [
                    RoomThumbnail(widget.room["thumbnail"]),
                    SizedBox(width: DEFAULT_PADDING),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            WeightLabel(widget.room["title"]),
                            // SizedBox(height: MICRO_PADDING),
                            Row(
                                children: [
                                    Icon(Icons.multitrack_audio_outlined),
                                    SizedBox(width: MICRO_PADDING),
                                    SubLabel(widget.room["desc"])
                                ],
                            ),
                        ],
                    ),
                    Spacer(),
                    BlueBadge(
                        Icon(
                            Icons.people_alt_sharp,
                            color: OBS_DEFAULT_TEXT_COLOR,
                        ),
                        "3",
                    )
                ],
            ),
        );
    }
}