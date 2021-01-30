import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeTopInfo extends StatelessWidget {
  final textStyle = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Hôm nay ", style: textStyle),
                Text(
                  "bạn muốn ăn gì?",
                  style: textStyle,
                )
              ],
            ),
          ]),
    );
  }
}
