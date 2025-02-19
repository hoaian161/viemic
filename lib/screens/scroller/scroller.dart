import 'package:flutter/cupertino.dart';
import 'package:viemic/screens/scroller/widgets/item.dart';

import '../../components/avatar.dart';
import '../../components/label.dart';
import '../../utils/color.dart';
import '../../utils/space.dart';

class Scroller extends StatefulWidget {
    @override
    State<Scroller> createState() => _ScrollerState();
}

class _ScrollerState extends State<Scroller> {
    @override
    Widget build(BuildContext context) {
        return SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.symmetric(vertical: DEFAULT_PADDING),
                child: Column(
                    children: [
                        Item(
                            thumbnail: "https://scontent.fvca1-2.fna.fbcdn.net/v/t39.30808-6/480251295_945763401095257_6316218738544618654_n.jpg?stp=cp6_dst-jpg_tt6&_nc_cat=104&ccb=1-7&_nc_sid=aa7b47&_nc_ohc=Cn1nKzl4zN4Q7kNvgE6isf0&_nc_oc=AdjwYCMCLniqJwP1-d6KMugBBdVuCHRJtKIpnwjIEdQlmS3qCVOJCAH4VvW5WGabE4OA78OywxR54W-vI2zAXGrN&_nc_zt=23&_nc_ht=scontent.fvca1-2.fna&_nc_gid=Akcal1tVFoQwUbvoudnh70R&oh=00_AYDq1SkX8CXQvOuG3qPoiWuoiekGJ9UQdMHYh-ICqGa0jA&oe=67BB64E1",
                            avatar: 'https://robohash.org/set_set3/bgset_bg1/danhminh',
                            title: 'danhminh',
                            desc: 'Minh la minh dang',
                            hashtag: '#linhloz'
                        ),
                        SizedBox(height: DEFAULT_PADDING),
                        Item(
                            thumbnail: "https://scontent.fvca1-4.fna.fbcdn.net/v/t39.30808-6/481103165_122140287230513540_929155184255329030_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=aa7b47&_nc_ohc=ssHL1fgvHxsQ7kNvgEs6UcK&_nc_oc=AdgJo2MoKTenUNEFLSyZe6M9U-_OVwccll75EYZHm2w51B0cVXxs1g98cJqfSguetY7ERttLL4qQZuwcvUhykJiO&_nc_zt=23&_nc_ht=scontent.fvca1-4.fna&_nc_gid=AhWLjeZnSC2EguRk7doIudz&oh=00_AYD3Q-wvOYoyhWeVrojerC7Pr2FO1BONtHYatJe6Vgi6HQ&oe=67BB79A2",
                            avatar: 'https://robohash.org/set_set3/bgset_bg1/tinh123',
                            title: 'tinh123',
                            desc: 'Hi iemmm',
                            hashtag: '#trending'
                        ),
                        SizedBox(height: DEFAULT_PADDING),
                        Item(
                            thumbnail: "https://scontent.fvca1-3.fna.fbcdn.net/v/t39.30808-6/476567103_1297394118140738_5653478662053340214_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=833d8c&_nc_ohc=wRtqdNSl_I0Q7kNvgE7Pl_Q&_nc_oc=Adg9lqB8UY5Z3mEMoF3Sbm1QMYRQ6by09dr-ELJYFKU-ri7HnF6RUKYcP6Ca5Or34vE3IMPaQaLIHSmVPbtDsbbq&_nc_zt=23&_nc_ht=scontent.fvca1-3.fna&_nc_gid=ALmJrizaWjospHH45xsgll0&oh=00_AYBh12xhfqaTWVeTURyqGJd-GcOnL7VrLDaf0OygGaE4kA&oe=67BB802B",
                            avatar: 'https://robohash.org/set_set3/bgset_bg1/linhks',
                            title: 'linhks',
                            desc: 'Bà trùm cho vay nặng lãi Kế Sách',
                            hashtag: '#kesach #chovay'
                        ),
                    ],
                ),
            ),
        );
    }
}