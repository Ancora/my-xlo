import 'package:flutter/material.dart';
import 'package:myxlo/screens/filter/widgets/animated_button.dart';
import 'package:myxlo/screens/filter/widgets/order_by_field.dart';
import 'package:myxlo/screens/filter/widgets/price_range_field.dart';
import 'package:myxlo/screens/filter/widgets/section_title.dart';
import 'package:myxlo/models/filter.dart';
import 'package:myxlo/screens/filter/widgets/vendor_type_field.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtrar busca'),
      ),
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                const SectionTitle(title: 'Ordenar por'),
                OrderByField(
                  initialValue: OrderBy.DATE,
                  onSaved: (v) {},
                ),
                const SectionTitle(title: 'Preço (R\$)'),
                PriceRangeField(),
                const SectionTitle(title: 'Tipo de anunciante'),
                VendorTypeField(
                  initialValue:
                      VENDOR_TYPE_PARTICULAR | VENDOR_TYPE_PROFESSIONAL,
                  onSaved: (v) {},
                ),
              ],
            ),
          ),
          AnimatedButton(
            scrollController: _scrollController,
            onTap: () {
              print('tocou!!!');
            },
          ),
        ],
      ),
    );
  }
}
