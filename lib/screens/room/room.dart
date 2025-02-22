import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    Widget build(BuildContext context) {
        return Text("ABC");
    }
}