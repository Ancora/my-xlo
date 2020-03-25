import 'package:flutter/material.dart';
import 'package:myxlo/models/ad.dart';

class LocationPanel extends StatelessWidget {
  final Ad ad;

  LocationPanel(this.ad);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 18),
          child: Text(
            'Localização',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: const <Widget>[
                  Text('CEP'),
                  SizedBox(height: 12),
                  Text('Município'),
                  SizedBox(height: 12),
                  Text('Bairro'),
                  SizedBox(height: 12),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Text('${ad.address.postalCode}'),
                    const SizedBox(height: 12),
                    Text('${ad.address.city}'),
                    const SizedBox(height: 12),
                    Text('${ad.address.district}'),
                    const SizedBox(height: 12),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
