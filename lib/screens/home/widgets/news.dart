import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
    @override
    State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
    @override
    Widget build(BuildContext context) {
        return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("https://i.pinimg.com/736x/37/05/7b/37057bb8a5b319e305b27232356e657f.jpg"),
                    fit: BoxFit.fitWidth,
                ),
                borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Text(
                                "VieMic",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                            ),
                        ],
                    ),
                    SizedBox(height: 16),
                    Text(
                        "Chào nhé",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight:
                            FontWeight.bold,
                        ),
                    ),
                    SizedBox(height: 8),
                    Text(
                        "- Tahu -",
                        style: TextStyle(color: Colors.white),
                    ),
                ],
            ),
        );
    }
}