import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

class CardRequest extends StatefulWidget {
  final Widget page;
  final String title;
  final Icon icon;
  const CardRequest({
    Key? key,
    required this.title,
    required this.icon,
    required this.page,
  }) : super(key: key);

  @override
  State<CardRequest> createState() => _CardRequestState();
}

class _CardRequestState extends State<CardRequest> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => widget.page));
          },
          child: SizedBox(
              width: 800,
              height: 60,
              child: Card(
                borderOnForeground: true,
                elevation: 3.0,
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.icon,
                  ),
                  Text(widget.title)
                ]),
              )),
        ));
  }
}
