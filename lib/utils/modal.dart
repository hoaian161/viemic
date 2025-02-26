import 'package:flutter/material.dart';

enum AnimationStyles { defaultStyle, custom, none }

void modal(BuildContext context, String message, AnimationStyles type, double height) {
    AnimationStyle? animationStyle;

    switch (type) {
        case AnimationStyles.defaultStyle:
            animationStyle = null;
            break;
        case AnimationStyles.custom:
            animationStyle = AnimationStyle(
                duration: const Duration(seconds: 2),
                reverseDuration: const Duration(seconds: 1),
            );
            break;
        case AnimationStyles.none:
            animationStyle = AnimationStyle.noAnimation;
            break;
    }

    showModalBottomSheet<void>(
        context: context,
        sheetAnimationStyle: animationStyle,
        builder: (BuildContext context) {
            return Container(
                height: MediaQuery.of(context).size.height * height,
                padding: const EdgeInsets.all(16),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                            Text(
                                message,
                                style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 10),
                        ],
                    ),
                ),
            );
        },
    );
}
