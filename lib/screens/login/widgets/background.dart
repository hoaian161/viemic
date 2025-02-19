import 'package:flutter/cupertino.dart';

class Background extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/backgrounds/login.jpg"),
                    fit: BoxFit.cover,
                ),
            ),
        );
    }
}