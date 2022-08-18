import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math' as math;
import 'package:expandable/expandable.dart';
import 'package:flutter_connect_mongdb/screens/request_amenity.dart';
import 'package:flutter_connect_mongdb/screens/request_property_type.dart';
import 'package:flutter_connect_mongdb/screens/request_verify_user.dart';
import 'package:flutter_connect_mongdb/screens/widgets/cardsRequest.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: SafeArea(
    //     child: CustomScrollView(slivers: [
    //       SliverToBoxAdapter(
    //         child: Center(
    //           child: ElevatedButton(
    //             onPressed: () {
    //               setState(() {
    //                 isShow = !isShow;
    //               });
    //             },
    //             child: Text("Show"),
    //           ),
    //         ),
    //       ),
    //       isShow
    //           ? SliverList(
    //               delegate: SliverChildBuilderDelegate((context, index) {
    //               return ListCard();
    //             }, childCount: 3))
    //           : SliverToBoxAdapter()
    //     ]),
    //   ),
    // );

    return Scaffold(
      body: ExpandableTheme(
          data: const ExpandableThemeData(
              iconColor: Colors.red, useInkWell: true),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [Card1()],
          )),
    );
  }
}

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed d";

class Card1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(
                          CarbonIcons.request_quote,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Request",
                            style: Theme.of(context).textTheme.bodyText2),
                      ],
                    )),
                collapsed: const Text(
                  'Tap to see more',
                  style: TextStyle(color: Colors.grey),
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CardRequest(
                      page: RequestAmenityScreen(),
                      icon: Icon(
                        CarbonIcons.face_activated_add,
                        color: Colors.grey,
                      ),
                      title: 'Request for amenity',
                    ),
                    CardRequest(
                      page: RequestPropertyTypeScreen(),
                      icon: Icon(CarbonIcons.qr_code, color: Colors.grey),
                      title: 'Request for property type',
                    ),
                    CardRequest(
                      page: RequestForVerifyUserScreen(),
                      icon: Icon(CarbonIcons.align_box_middle_right,
                          color: Colors.grey),
                      title: 'Request for verify',
                    ),
                  ],
                ),
                builder: (i, collapsed, expanded) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}




// class ListCard extends StatefulWidget {
//   const ListCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<ListCard> createState() => _ListCardState();
// }

// class _ListCardState extends State<ListCard> with TickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation animation;

//   @override
//   void initState() {
//     controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 700));
//     animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut)
//       ..addListener(() {
//         setState(() {});
//       });
//     super.initState();
//     setState(() {});
//     controller.forward(from: 0.0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Transform(
//         transform:
//             Matrix4.translationValues(0, -500.0 + (animation.value * 500.0), 0),
//         child: SizedBox(height: 100, child: Card()));
//   }
// }
