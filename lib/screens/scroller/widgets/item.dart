import 'package:flutter/cupertino.dart';

import '../../../components/avatar.dart';
import '../../../components/label.dart';
import '../../../utils/space.dart';

class Item extends StatefulWidget {
    final String thumbnail, avatar, title, desc, hashtag;

    const Item({
        super.key,
        required this.thumbnail,
        required this.avatar,
        required this.title,
        required this.desc,
        required this.hashtag
    });

    @override
    State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
    @override
    Widget build(BuildContext context) {
        return Stack(
            children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                        widget.thumbnail,
                        width: double.infinity,
                    ),
                ),
                Positioned(
                    bottom: DEFAULT_PADDING,
                    left: DEFAULT_PADDING,
                    child: Container(
                        padding: EdgeInsets.all(MICRO_PADDING),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                OBSWeightLabel(widget.title),
                                SizedBox(height: SMALL_PADDING),
                                OBSSubLabel(widget.desc),
                                HashtagLabel(widget.hashtag)
                            ],
                        ),
                    ),
                ),
            ],
        );
    }
}