import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:viemic/utils/color.dart';
import 'package:viemic/utils/space.dart';

import 'internal.dart';

Map<String, dynamic> user = Internal().get("user");

void userPopup(BuildContext context, Map<String, dynamic>? targetUser) {
    List<String> userCoords = user["address"].split(",");
    List<String> targetCoords = targetUser!["address"].split(",");

    double distanceInMeters = Geolocator.distanceBetween(
        double.parse(userCoords[0]),
        double.parse(userCoords[1]),
        double.parse(targetCoords[0]),
        double.parse(targetCoords[1])
    );

    double distanceInKm = distanceInMeters / 1000;

    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.2,
                padding: const EdgeInsets.all(16),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                            Row(
                                children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                            targetUser["avatar"],
                                            width: 60,
                                        ),
                                    ),
                                    SizedBox(width: DEFAULT_PADDING),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Row(
                                                children: [
                                                    Text(
                                                        targetUser["name"],
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                            color: BLACK_COLOR
                                                        ),
                                                    ),
                                                    SizedBox(width: MICRO_PADDING),
                                                    if (targetUser["badge"] != "" && targetUser["badge"] != null)
                                                        Image.asset(
                                                            "assets/images/badges/${targetUser["badge"]}.png",
                                                            width: 18
                                                        ),
                                                ],
                                            ),
                                            if (targetUser["role"] != "" && targetUser["role"] != null)
                                                Text(
                                                    "${targetUser["role"]}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: FADED_1_COLOR,
                                                    ),
                                                )
                                        ],
                                    ),
                                    Spacer(),
                                    Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                            color: FADED_2_COLOR,
                                            borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Text(
                                            "${distanceInKm.toStringAsFixed(2)} km",
                                            style: TextStyle(color: Colors.grey),
                                        ),
                                    )
                                ],
                            ),
                            const SizedBox(height: 10),
                        ],
                    ),
                ),
            );
        },
    );
}
