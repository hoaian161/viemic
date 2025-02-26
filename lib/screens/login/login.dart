import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:viemic/screens/login/widgets/background.dart';

import '../../apis/general.dart';
import '../../apis/google_login.dart';
import '../../components/label.dart';
import '../../utils/color.dart';
import '../../utils/internal.dart';
import '../../utils/modal.dart';
import '../../utils/space.dart';
import '../../utils/storage.dart';
import '../home/home.dart';

class Login extends StatefulWidget {
    @override
    State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
    final storage = Storage();
    bool isFirstLogin = false;

    @override
    void initState() {
        super.initState();
        initLogin();
    }

    Future<void> initLogin() async {
        final savedSession = await storage.get("user");

        if (savedSession != "null") {
            await authVerify(savedSession);
        } else {
            print("First loginnn");
            setState(() {
                isFirstLogin = true;
            });
        }
    }

    Future<void> authVerify(String user) async {
        Map<String, dynamic> getVersion = await server("getVersion", "");
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        PermissionStatus microphoneGrant = await Permission.microphone.request();
        PermissionStatus locationGrant = await Permission.location.request();

        if (getVersion.isEmpty) {
            modal(context, "Không thể kết nối với máy chủ", AnimationStyles.defaultStyle, 0.20);
            return;
        } else if (getVersion["data"]["version"] != packageInfo.version) {
            modal(context, "Ứng dụng đã có phiên bản mới, hãy cập nhật để tiếp tục nhé", AnimationStyles.defaultStyle, 0.20);
            return;
        } else if (!microphoneGrant.isGranted || !locationGrant.isGranted) {
            modal(context, "Bạn cần cấp các quyền cần thiết để tiếp tục", AnimationStyles.defaultStyle, 0.20);
            return;
        }

        setState(() {
            isFirstLogin = false;
        });

        Position userPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high
        );

        Map<String, dynamic> authRequest = await server("auth", "user=${user}&position=${userPosition.latitude},${userPosition.longitude}");

        if (authRequest["code"] == true) {
            Map<String, dynamic> user = authRequest["data"]["user"];
            await storage.set("user", jsonEncode(user));
            Internal().set("user", user);
            Internal().set("isJoined", "");
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        } else {
            modal(context, authRequest["message"], AnimationStyles.defaultStyle, 0.20);
            return;
        }
    }

    Future<void> signIn() async {
        try {
            final user = await GoogleSignInApi.login();

            if (user == null) {
                modal(context, "Đăng nhập thất bại, hãy thử lại sau", AnimationStyles.defaultStyle, 0.20);
            } else {
                Map<String, String> userData = {
                    'id': user.id,
                    'displayName': user.displayName ?? '',
                    'email': user.email,
                    'photoUrl': user.photoUrl ?? '',
                };

                String userJson = jsonEncode(userData);
                await authVerify(userJson);
            }
        } catch (e) {
            print("Error during sign-in: $e");
            modal(context, "Lỗi trong quá trình đăng nhập: $e", AnimationStyles.defaultStyle, 0.20);
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Stack(
                children: [
                    Background(),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.17,
                        left: 0,
                        right: 0,
                        child: Center(
                            child: BigLabel("viemic", WHITE_COLOR),
                        ),
                    ),
                    if (isFirstLogin)
                        Positioned(
                            top: MediaQuery.of(context).size.height * 0.90,
                            right: 16,
                            child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () => {
                                    if (isFirstLogin)
                                        signIn()
                                },
                                child: Container(
                                    width: 260,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                            SizedBox(width: 10),
                                            Image.asset(
                                                "assets/images/icons/google.png",
                                                width: 35,
                                                height: 35,
                                            ),
                                            SizedBox(width: 13),
                                            DefaultLabel("Tiếp tục với Google", BLACK_COLOR),
                                            Spacer(),
                                        ],
                                    ),
                                ),
                            ),
                        ),
                ],
            ),
        );
    }
}
