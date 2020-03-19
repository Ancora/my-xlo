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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  Filter _filter = Filter(
    maxPrice: 100,
    minPrice: 10,
    vendorType: VENDOR_TYPE_PARTICULAR,
    orderBy: OrderBy.PRICE,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  initialValue: _filter.orderBy,
                  onSaved: (v) {
                    _filter.orderBy = v;
                  },
                ),
                const SectionTitle(title: 'Preço (R\$)'),
                PriceRangeField(
                  filter: _filter,
                ),
                const SectionTitle(title: 'Tipo de anunciante'),
                VendorTypeField(
                  initialValue: _filter.vendorType,
                  onSaved: (v) {
                    _filter.vendorType = v;
                  },
                ),
              ],
            ),
          ),
          AnimatedButton(
            scrollController: _scrollController,
            onTap: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                if (_filter.maxPrice != null && _filter.minPrice != null) {
                  if (_filter.minPrice > _filter.maxPrice) {
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Faixa de preços inválida!',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                }
                // SALVAR TUDO E PESQUISAR ANÚNCIOS
              }
            },
          ),
        ],
      ),
    );
  }
}
