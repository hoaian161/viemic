import 'package:flutter/material.dart';

import '../../../utils/color.dart';

TabBar Tabs() {
    return TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        labelColor: DEFAULT_TEXT_COLOR,
        unselectedLabelColor: FADED_TEXT_COLOR,
        tabs: [
            Tab(text: "Đề xuất"),
            Tab(text: "Quanh đây"),
            Tab(text: "Hoạt động"),
        ],
    );
}