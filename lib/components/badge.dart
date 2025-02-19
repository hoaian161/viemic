import 'package:flutter/cupertino.dart';
import 'package:viemic/utils/space.dart';

import '../utils/color.dart';

Widget BlueBadge(Icon icon, String text) {
    return Container(
        padding: EdgeInsets.all(MICRO_PADDING),
        decoration: BoxDecoration(
            color: BLUE_TEXT_COLOR,
            borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
            children: [
                SizedBox(width: MICRO_PADDING),
                icon,
                SizedBox(width: MICRO_PADDING),
                Text(
                    text,
                    style: TextStyle(
                        color: OBS_DEFAULT_TEXT_COLOR,
                    )
                ),
                SizedBox(width: MICRO_PADDING),
            ],
        ),
    );
}