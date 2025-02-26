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
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Image.asset(icon),
                ),
                SizedBox(height: 3),
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
                    "assets/images/icons/distance.png",
                    "Gần đây"
                ),
                _featureButton(
                    "assets/images/icons/friends.png",
                    "Bạn bè"
                ),
                _featureButton(
                    "assets/images/icons/edit.png",
                    "Hồ sơ"
                ),
            ],
        );
    }
}