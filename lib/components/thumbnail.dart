import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:viemic/utils/color.dart';
import 'package:viemic/utils/size.dart';

Widget DefaultThumbnail(String url) {
    return Container(
        padding: EdgeInsets.all(5),
        width: DEFAULT_THUMBNAIL_SIZE + 5,
        decoration: BoxDecoration(
            color: FADED_BACKGROUND_COLOR,
            borderRadius: BorderRadius.circular(50)
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
                url,
                width: DEFAULT_THUMBNAIL_SIZE,
            ),
        ),
    );
}