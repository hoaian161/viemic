import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/utils/color.dart';
import 'package:viemic/utils/size.dart';

Text SubLabel(String text, Color color) {
    return Text(
        text,
        style: TextStyle(
            color: color,
            fontSize: SUB_TEXT_SIZE,
        ),
    );
}

Text DefaultLabel(String text, Color color) {
    return Text(
        text,
        style: TextStyle(
            color: color,
            fontSize: DEFAULT_TEXT_SIZE,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
    );
}

Text WeightLabel(String text, Color color) {
    return Text(
        text,
        style: TextStyle(
            color: color,
            fontSize: DEFAULT_TEXT_SIZE,
            fontWeight: FontWeight.w500,
        ),
    );
}

Text StrongLabel(String text, Color color) {
    return Text(
        text,
        style: TextStyle(
            color: color,
            fontSize: STRONG_TEXT_SIZE,
            fontWeight: FontWeight.bold,
        ),
    );
}

Text BigLabel(String text, Color color) {
    return Text(
        text,
        style: TextStyle(
            color: color,
            fontSize: BIG_TEXT_SIZE,
            fontWeight: FontWeight.bold,
        ),
    );
}

Text HashtagLabel(String text, Color color) {
    return Text(
        text,
        style: TextStyle(
            color: color,
            fontSize: SUB_TEXT_SIZE,
            fontWeight: FontWeight.bold,
        ),
    );
}