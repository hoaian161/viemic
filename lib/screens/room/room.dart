import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:viemic/screens/room/widgets/chair.dart';
import 'package:viemic/utils/color.dart';

import '../../components/label.dart';
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
    final List<int> _users = [];
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

        socket.onDisconnect((_) => print("Disconnected Rooms server"));

        socket.onConnectError((error) {
            print("Socket Error: $error");
        });

        socket.onError((error) {
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
                "sender": "Bạn",
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
                    await _engine!.muteLocalAudioStream(_isMicMuted);
                    setState(() {
                        _users.add(uid);
                    });
                },
                onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
                    debugPrint("Remote user $remoteUid joined");
                    setState(() {
                        _users.add(remoteUid);
                    });
                },
                onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
                    debugPrint("Remote user $remoteUid left");
                    setState(() {
                        _users.remove(remoteUid);
                    });
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
            });
            await _engine!.muteLocalAudioStream(_isMicMuted);
        }
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: "VieMic",
            theme: DefaultTheme(),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: SafeArea(
                    child: Padding(
                        padding: EdgeInsets.all(DEFAULT_SCREEN_PADDING),
                        child: Column(
                            children: [
                                Header(room: widget.room, kickMessage: _kickMessage),
                                SizedBox(height: 10),
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.only(bottom: 16, top: 20),
                                    child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: _users.map((user) {
                                            return Chair(uid: user);
                                        }).toList(),
                                    ),
                                ),
                                Expanded(
                                    child: ListView.builder(
                                        itemCount: _messages.length,
                                        itemBuilder: (context, index) {
                                            return Align(
                                                alignment: _messages[index]["sender"] == "Bạn"
                                                    ? Alignment.centerRight
                                                    : Alignment.centerLeft,
                                                child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                                    margin: EdgeInsets.symmetric(vertical: 5),
                                                    decoration: BoxDecoration(
                                                        // color: _messages[index]["sender"] == "Bạn"
                                                        //     ? Colors.blueAccent
                                                        //     : Colors.grey[800],
                                                        borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                            SubLabel(_messages[index]["sender"]!, FADED_1_COLOR),
                                                            SizedBox(height: 5),
                                                            DefaultLabel(_messages[index]["text"]!, BLACK_COLOR),
                                                        ],
                                                    ),
                                                ),
                                            );
                                        },
                                    ),
                                ),
                                Container(
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
                                                    width: 45,
                                                ),
                                            ),
                                            SizedBox(width: 20),
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
                                                                    controller: _messageController,
                                                                    decoration: InputDecoration(
                                                                        hintText: "Nhập tin nhắn...",
                                                                        hintStyle: TextStyle(
                                                                            color: BLACK_COLOR,
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
                ),
            ),
        );
    }
}