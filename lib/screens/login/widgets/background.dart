import 'package:flutter/cupertino.dart';

class Background extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    //https://i.pinimg.com/736x/ba/30/1a/ba301ad3f71a00bfb92be6c1fda4eb8d.jpg
                    image: Image.asset("assets/images/backgrounds/login.png").image,
                    fit: BoxFit.fitWidth,
                ),
            ),
        );
    }
}