import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/utils/color.dart';

import '../../../utils/internal.dart';

Map<String, dynamic> user = Internal().get("user");

class Infomation extends StatefulWidget {
    @override
    State<Infomation> createState() => _CurrencyState();
}

class _CurrencyState extends State<Infomation> {
    Widget _infomationButton(String label, bool selected) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: selected ? FADED_2_COLOR : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                    ),
                ],
            ),
            child: Text(
                label,
                style: TextStyle(color: Colors.grey),
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Row(
                    children: [
                        _infomationButton("${user["coin"]} xu", true),
                        SizedBox(width: 8),
                        _infomationButton("ID: ${user["id"]}", false),
                    ],
                ),
                Text(
                    "Nạp ngay",
                    style: TextStyle(color: BLACK_COLOR),
                ),
            ],
        );
    }
}