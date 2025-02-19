import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/color.dart';

Widget DefaultDivider() {
    return Divider(
        color: FADED_BACKGROUND_COLOR,
        thickness: 1,
        indent: 10,
        endIndent: 10,
    );
}