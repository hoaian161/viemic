import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:viemic/utils/size.dart';

Widget DefaultAvatar(String url) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
            url,
            width: DEFAULT_AVATAR_SIZE,
        ),
    );
}