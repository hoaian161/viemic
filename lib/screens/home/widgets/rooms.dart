import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/utils/color.dart';

import '../../../apis/general.dart';
import '../../../utils/internal.dart';
import '../../../utils/modal.dart';
import '../../../utils/space.dart';
import '../../room/room.dart';

class Rooms extends StatefulWidget {
    @override
    State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
    List<Widget> rooms = [];

    @override
    void initState() {
        super.initState();
        getRooms();
    }

    void getRooms() async {
        List<Widget> newRooms = [];
        Map<String, dynamic> data = await server("getRooms", "");
        print(data["data"]["config"]["appID"]);

        for (var roomElm in data["data"]["rooms"]) {
            newRooms.add(_roomItem(roomElm));
        }

        setState(() {
            rooms = newRooms;
        });
    }

    Widget _roomItem(Map<String, dynamic> room) {
        return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
                if (Internal().get("isJoined") == room["id"]) {
                    Navigator.pop(context);
                } else if (Internal().get("isJoined") == "") {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Room(room: room),
                        ),
                    );
                } else {
                    modal(context, "Bạn cần rời khỏi phòng hiện tại trước khi tham gia phòng khác", AnimationStyles.defaultStyle, 0.20);
                }
            },
            child: Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Row(
                            children: [
                                CircleAvatar(
                                    radius: 30,
                                    backgroundColor: FADED_2_COLOR,
                                    backgroundImage: NetworkImage(room["thumbnail"]),
                                ),
                                SizedBox(width: 12),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                            room["title"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                            ),
                                        ),
                                        Text(
                                            room["desc"],
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                            ),
                                        ),
                                    ],
                                ),
                            ],
                        ),
                        Container(
                            padding: EdgeInsets.all(MICRO_PADDING),
                            decoration: BoxDecoration(
                                color: BLUE_COLOR,
                                borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                                children: [
                                    SizedBox(width: MICRO_PADDING),
                                    Icon(
                                        Icons.people_alt_sharp,
                                        color: Colors.white
                                    ),
                                    SizedBox(width: MICRO_PADDING),
                                    Text(
                                        "0",
                                        style: TextStyle(
                                            color: WHITE_COLOR,
                                        )
                                    ),
                                    SizedBox(width: MICRO_PADDING),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text(
                            "Phòng có sẵn",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                            ),
                        ),
                    ],
                ),
                rooms.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox(
                    height: 400,
                    child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 100, top: 16),
                        itemCount: rooms.length,
                        itemBuilder: (context, index) {
                            return rooms[index];
                        }
                    ),
                ),
            ],
        );
    }
}
