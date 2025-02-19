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

Text OBSSubLabel(String text) {
    return Text(
        text,
        style: TextStyle(
            color: OBS_DEFAULT_TEXT_COLOR,
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
    );
}

Text OBSDefaultLabel(String text) {
    return Text(
        text,
        style: TextStyle(
            color: OBS_DEFAULT_TEXT_COLOR,
            fontSize: DEFAULT_TEXT_SIZE,
        ),
    );
}

Text WeightLabel(String text) {
    return Text(
        text,
        style: TextStyle(
            color: DEFAULT_TEXT_COLOR,
            fontSize: DEFAULT_TEXT_SIZE,
            fontWeight: FontWeight.w600,
        ),
    );
}

Text OBSWeightLabel(String text) {
    return Text(
        text,
        style: TextStyle(
            color: OBS_DEFAULT_TEXT_COLOR,
            fontSize: DEFAULT_TEXT_SIZE,
            fontWeight: FontWeight.w600,
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