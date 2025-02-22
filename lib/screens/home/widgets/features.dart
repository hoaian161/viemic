import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Features extends StatefulWidget {
    @override
    State<Features> createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {
    Widget _featureButton(String icon, String label) {
        return Column(
            children: [
                CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    radius: 24,
                    child: Image.asset(icon),
                ),
                SizedBox(height: 8),
                Text(
                    label,
                    style: TextStyle(fontSize: 14)
                ),
            ],
        );
    }
    
    @override
    Widget build(BuildContext context) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
                _featureButton(
                    "assets/images/other/add_friend.png",
                    "Thêm bạn"
                ),
                _featureButton(
                    "assets/images/other/friends.png",
                    "Bạn bè"
                ),
                _featureButton(
                    "assets/images/other/edit.png",
                    "Hồ sơ"
                ),
            ],
        );
    }
}