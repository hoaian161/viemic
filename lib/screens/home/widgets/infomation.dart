import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viemic/utils/color.dart';

class Infomation extends StatefulWidget {
    @override
    State<Infomation> createState() => _CurrencyState();
}

class _CurrencyState extends State<Infomation> {
    Widget _infomationButton(String label, bool selected) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: selected ? ORANGE_COLOR : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
                label,
                style: TextStyle(color: selected ? Colors.white : Colors.grey),
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
                        _infomationButton("0 xu", true),
                        SizedBox(width: 8),
                        _infomationButton("ID: 1", false),
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