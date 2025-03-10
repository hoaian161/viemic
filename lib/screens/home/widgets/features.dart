import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/modal.dart';

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
                InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                        modal(context, "Tính năng không khả dụng trên phiên bản thử nghiệm", AnimationStyles.defaultStyle, 0.20);
                    },
                    child: _featureButton(
                        "assets/images/icons/distance.png",
                        "Gần đây"
                    ),
                ),
                InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                        modal(context, "Tính năng không khả dụng trên phiên bản thử nghiệm", AnimationStyles.defaultStyle, 0.20);
                    },
                    child: _featureButton(
                        "assets/images/icons/friends.png",
                        "Bạn bè"
                    ),
                ),
                InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                        modal(context, "Tính năng không khả dụng trên phiên bản thử nghiệm", AnimationStyles.defaultStyle, 0.20);
                    },
                    child: _featureButton(
                        "assets/images/icons/edit.png",
                        "Hồ sơ"
                    ),
                ),
            ],
        );
    }
}