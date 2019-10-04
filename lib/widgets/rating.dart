import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Container(
        height: 35,
        width: 35,
        child: IconButton(
          iconSize: 25,
          onPressed: () {},
          icon: Icon(Icons.star),
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
