import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/utils/color.dart';
import 'package:viemic/utils/size.dart';

Text SubLabel(String text) {
    return Text(
        text,
        style: TextStyle(
            color: FADED_TEXT_COLOR,
            fontSize: SUB_TEXT_SIZE,
        ),
    );
}

Text DefaultLabel(String text) {
    return Text(
        text,
        style: TextStyle(
            color: DEFAULT_TEXT_COLOR,
            fontSize: DEFAULT_TEXT_SIZE,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
    );
}

Text WeightLabel(String text) {
    return Text(
        text,
        style: TextStyle(
            color: DEFAULT_TEXT_COLOR,
            fontSize: DEFAULT_TEXT_SIZE,
            fontWeight: FontWeight.w500,
        ),
    );
}

Text StrongLabel(String text) {
    return Text(
        text,
        style: TextStyle(
            color: DEFAULT_TEXT_COLOR,
            fontSize: STRONG_TEXT_SIZE,
            fontWeight: FontWeight.bold,
        ),
    );
}

Text BigLabel(String text) {
    return Text(
        text,
        style: TextStyle(
            color: OBS_DEFAULT_TEXT_COLOR,
            fontSize: BIG_TEXT_SIZE,
            fontWeight: FontWeight.bold,
        ),
    );
}

Text HashtagLabel(String text) {
    return Text(
        text,
        style: TextStyle(
            color: Colors.blueAccent,
            fontSize: SUB_TEXT_SIZE,
            fontWeight: FontWeight.bold,
        ),
    );
}