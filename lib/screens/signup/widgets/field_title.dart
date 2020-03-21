import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const FieldTitle({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '$title   ',
            style: TextStyle(
              color: Colors.blueGrey[800],
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '$subtitle',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
