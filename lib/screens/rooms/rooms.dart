import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/screens/rooms/widgets/room.dart';

import '../../apis/general.dart';
import '../../utils/internal.dart';

Map<String, dynamic> user = Internal().get("user");

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
            newRooms.add(Room(room: roomElm));
        }

        setState(() {
            rooms = newRooms;
        });
    }

    @override
    Widget build(BuildContext context) {
        return rooms.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
            padding: EdgeInsets.only(bottom: 16, top: 20),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
                return rooms[index];
            },
        );
    }
}