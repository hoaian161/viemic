import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/cupertino.dart';
import 'package:viemic/screens/room/widgets/chair.dart';

import '../../components/label.dart';
import '../../utils/color.dart';
import '../../utils/internal.dart';
import '../../utils/modal.dart';
import '../../utils/space.dart';
import '../../utils/theme.dart';
import '../home/home.dart';
import '../room/widgets/header.dart';

Map<String, dynamic> user = Internal().get("user");

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
    final Map<int, Map<String, dynamic>> _users = {};
    RtcEngine? _engine;
    late IO.Socket socket;
    bool _isMicMuted = true;
    bool _isChatable = false;

    int uid = int.parse(user["id"]);

    List<Map<String, String>> _messages = [];
    TextEditingController _messageController = TextEditingController();

    @override
    void initState() {
        super.initState();
        _initAgora();
        _initRoomsSocket();
        Internal().set("isJoined", widget.room["id"]);
    }

    Future<void> _initRoomsSocket() async {
        socket = IO.io(widget.room["roomsAdr"], <String, dynamic>{
            "transports": ["websocket"],
            "autoConnect": true,
        });

        socket.onConnect((_) {
            setState(() {
                _isChatable = true;
            });
            print("Connected to Rooms server");
        });

        socket.on("event", (data) {
            print("Received: $data");

            if (data["type"] == "room_message") {
                if (data["data"]["id"] == widget.room["id"]) {
                    setState(() {
                        _messages.add({
                            "sender": data["data"]["sender"].toString(),
                            "text": data["data"]["text"].toString(),
                        });
                    });
                }
            }
        });

        socket.onReconnect((_) {
            setState(() {
                _isChatable = true;
            });
            print("Reconnected Rooms server");
        });

        socket.onDisconnect((_) {
            setState(() {
                _isChatable = false;
            });
            print("Disconnected Rooms server");
        });

        socket.onConnectError((error) {
            setState(() {
                _isChatable = false;
            });
            print("Socket Error: $error");
        });

        socket.onError((error) {
            setState(() {
                _isChatable = false;
            });
            print("Socket Error: $error");
        });
    }

    void _sendMessage() {
        if (_messageController.text.trim().isEmpty) return;
        String message = _messageController.text.trim();

        socket.emit("event", {
            "type": "room_message",
            "data": {
                "id": widget.room["id"],
                "sender": user["name"],
                "text": message
            },
        });

        setState(() {
            _messages.add({
                "sender": user["name"],
                "text": message,
            });
        });

        _messageController.clear();
    }

    Future<void> _initAgora() async {
        final status = await Permission.microphone.request();
        if (!status.isGranted) {
            debugPrint("Microphone permission denied");
            return;
        }

        _engine = createAgoraRtcEngine();
        await _engine!.initialize(RtcEngineContext(
            appId: widget.room["appID"],
            channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ));

        _engine!.registerEventHandler(
            RtcEngineEventHandler(
                onJoinChannelSuccess: (RtcConnection connection, int elapsed) async {
                    debugPrint("Local user ${connection.localUid} joined");
                    await _engine!.muteLocalAudioStream(true);
                    setState(() {
                        _users[uid] = {
                            "isMute": true,
                            "volume": 0,
                        };
                    });
                },

                onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
                    debugPrint("Remote user $remoteUid joined");
                    setState(() {
                        _users[remoteUid] = {
                            "isMute": true,
                            "volume": 0,
                        };
                    });
                },

                onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
                    debugPrint("Remote user $remoteUid left");
                    setState(() {
                        _users.remove(remoteUid);
                    });
                },

                onUserMuteAudio: (RtcConnection connection, int remoteUid, bool muted) {
                    debugPrint("Remote user $remoteUid mute change");
                    setState(() {
                        _users[remoteUid]!["isMute"] = muted;
                        _users[remoteUid]!["volume"] = 0;
                    });
                },

                onAudioVolumeIndication: (RtcConnection connection, List<AudioVolumeInfo> speakers, int speakerNumber, int totalVolume) {
                    if (speakers.isNotEmpty) {
                        setState(() {
                            for (var speaker in speakers) {
                                if (_users.containsKey(speaker.uid)) {
                                    _users[speaker.uid]!["volume"] = speaker.volume;
                                }
                            }
                        });
                    }
                },

                onError: (ErrorCodeType code, String message) async {
                    debugPrint("Error: $code - $message");
                    await _kickMessage("Phòng này đã bị xoá");
                },
            ),
        );

        await _engine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
        await _engine!.enableAudio();
        await _engine!.joinChannel(
            token: widget.room["token"],
            channelId: widget.room["id"],
            uid: uid,
            options: const ChannelMediaOptions(),
        );

        await _engine!.enableAudioVolumeIndication(
            interval: 200,
            smooth: 3,
            reportVad: true,
        );
    }

    @override
    void dispose() {
        _disposeAgora();
        super.dispose();
    }

    Future<void> _kickMessage(String message) async {
        await _disposeAgora();
        Internal().set("isJoined", "");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(),
            ),
        );
        modal(context, message, AnimationStyles.defaultStyle, 0.20);
    }

    Future<void> _disposeAgora() async {
        if (_engine != null) {
            await _engine!.leaveChannel();
            await _engine!.release();
            _engine = null;
        }
    }

    Future<void> _toggleMuteMic() async {
        if (_engine != null) {
            setState(() {
                _isMicMuted = !_isMicMuted;
                _users[uid]!["isMute"] = _isMicMuted;
            });
            await _engine!.muteLocalAudioStream(_isMicMuted);
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Column(
                    children: [
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Header(room: widget.room, kickMessage: _kickMessage),
                                    SizedBox(height: 10),
                                    SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.only(bottom: 16, top: 20),
                                        child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: (){
                                                var sortedEntries = _users.entries.toList();
                                                sortedEntries.sort((a, b) => a.key.compareTo(b.key));
                                                return sortedEntries.map((entry) => Chair(
                                                    uid: entry.key,
                                                    key: ValueKey(entry.key),
                                                    userObj: entry.value
                                                )).toList();
                                            }(),
                                        ),
                                    ),
                                ],
                            ),
                        ),
                        Expanded( // This will take remaining space
                            child: ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                itemCount: _messages.length,
                                itemBuilder: (context, index) {
                                    return Align(
                                        alignment: _messages[index]["sender"] == user["name"]
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            margin: EdgeInsets.symmetric(vertical: 10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: FADED_2_COLOR,
                                            ),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    Text(
                                                        _messages[index]["sender"]!,
                                                        style: TextStyle(
                                                            color: FADED_1_COLOR,
                                                            fontSize: 14,
                                                        ),
                                                    ),
                                                    Text(
                                                        _messages[index]["text"]!,
                                                        style: TextStyle(
                                                            color: BLACK_COLOR,
                                                            fontSize: 16,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    );
                                },
                            ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: Row(
                                children: [
                                    InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: _toggleMuteMic,
                                        child: Image.asset(
                                            _isMicMuted
                                                ? "assets/images/icons/mic_close.png"
                                                : "assets/images/icons/mic_open.png",
                                            width: 40,
                                        ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 16),
                                            decoration: BoxDecoration(
                                                color: FADED_2_COLOR,
                                                borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                                children: [
                                                    Expanded(
                                                        child: TextField(
                                                            enabled: _isChatable,
                                                            controller: _messageController,
                                                            decoration: InputDecoration(
                                                                hintText: (_isChatable ? "Nhập tin nhắn..." : "Phòng này không thể nhắn"),
                                                                hintStyle: TextStyle(
                                                                    color: BLACK_COLOR,
                                                                    fontSize: 16,
                                                                ),
                                                                border: InputBorder.none,
                                                            ),
                                                            style: TextStyle(
                                                                color: BLACK_COLOR,
                                                            ),
                                                        ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    InkWell(
                                                        splashColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: _sendMessage,
                                                        child: Image.asset(
                                                            "assets/images/icons/edit.png",
                                                            width: 20,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}