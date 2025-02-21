import 'package:flutter/material.dart';

import '../../../utils/color.dart';

TabBar Tabs() {
    return TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        labelColor: BLUE_COLOR,
        unselectedLabelColor: FADED_1_COLOR,
        tabs: [
            Tab(
                icon: Icon(
                    Icons.multitrack_audio,
                    size: 40,
                ),
            ),
            // Tab(text: "Quanh đây"),
            Tab(
                icon: Icon(
                    Icons.connect_without_contact,
                    size: 40,
                ),
            ),
        ],
    );
}