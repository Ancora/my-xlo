import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myxlo/helpers/format_field.dart';
import 'package:myxlo/models/filter.dart';

class PriceRangeField extends StatelessWidget {
  final Filter filter;

  PriceRangeField({this.filter});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Mínimo',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              RealInputFormatter(centavos: false),
            ],
            initialValue: filter.minPrice?.toString(),
            onSaved: (s) {
              if (s.isEmpty) {
                filter.minPrice = null;
              } else {
                filter.minPrice = int.parse(getSanitizedText(s));
              }
            },
            validator: (s) {
              if (s.isNotEmpty && int.tryParse(getSanitizedText(s)) == null) {
                return 'Utilize valores válidos';
              } else {
                return null;
              }
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Máximo',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              RealInputFormatter(centavos: false),
            ],
            initialValue: filter.maxPrice?.toString(),
            onSaved: (s) {
              if (s.isEmpty) {
                filter.maxPrice = null;
              } else {
                filter.maxPrice = int.parse(getSanitizedText(s));
              }
            },
            validator: (s) {
              if (s.isNotEmpty && int.tryParse(getSanitizedText(s)) == null) {
                return 'Utilize valores válidos';
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }
}
