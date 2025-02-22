import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {
    @override
    State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
    @override
    Widget build(BuildContext context) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("https://scontent.fsgn2-10.fna.fbcdn.net/v/t39.30808-6/480985487_1170147727959645_1694118446548528336_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=Www5zgwDV2cQ7kNvgHAErGM&_nc_oc=AdgVn_WD74seP6qJbtO-z1-FdsaUAOLq9kgRIlEgNSZLpFVsEwFXFWhEhqMm-plCP2s&_nc_zt=23&_nc_ht=scontent.fsgn2-10.fna&_nc_gid=AsXp0_qanbd4tLQt7MCxWq-&oh=00_AYDlqaP_VUCQEULwaQekU6Gudpz9nDAODDZpcpttb2exGw&oe=67BFF3E4"),
                ),
                SizedBox(width: 16),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                            "Chào cậu,",
                            style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                            "hoaiandev",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                            ),
                        ),
                    ],
                ),
            ],
        );
    }
}