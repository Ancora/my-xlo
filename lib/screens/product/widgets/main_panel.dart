import 'package:flutter/material.dart';
import 'package:myxlo/helpers/format_field.dart';
import 'package:myxlo/models/ad.dart';

class MainPanel extends StatelessWidget {
  final Ad ad;

  const MainPanel(this.ad);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 14),
          child: Text(
            'R\$ ${numToString(ad.price)}',
            style: TextStyle(
              fontSize: 34,
              letterSpacing: 2.8,
              fontWeight: FontWeight.w300,
              color: Colors.blueGrey[800],
            ),
          ),
        ),
        Text(
          ad.title,
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 1,
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 18),
          child: Text(
            'Publicado em ${dateToString(ad.dateCreated)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.blueGrey[600],
            ),
          ),
        ),
      ],
    );
  }
}
