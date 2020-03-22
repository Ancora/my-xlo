import 'dart:html';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myxlo/api/api_postalcode.dart';
import 'package:myxlo/common/cep_field.dart';
import 'package:myxlo/common/custom_drawer/custom_drawer.dart';
import 'package:myxlo/screens/create/widgets/images_field.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inserir Anúncio'),
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            ImagesField(
              onSaved: (images) {
                // salvar as imagens
              },
              initialValue: [],
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Título *',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.blueGrey,
                  fontSize: 18,
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
              ),
              validator: (text) {
                if (text.isEmpty) {
                  return 'Campo obrigatório!';
                } else {
                  return null;
                }
              },
              onSaved: (t) {},
            ),
            TextFormField(
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Descrição *',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.blueGrey,
                  fontSize: 18,
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
              ),
              validator: (text) {
                if (text.trim().isEmpty) {
                  return 'Campo obrigatório!';
                } else if (text.trim().length < 10) {
                  return 'Descrição muito curta!';
                } else {
                  return null;
                }
              },
              onSaved: (d) {},
            ),
            CepField(
              decoration: InputDecoration(
                labelText: 'CEP *',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.blueGrey,
                  fontSize: 18,
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
              ),
              onSaved: (a) {},
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Preço *',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.blueGrey,
                  fontSize: 18,
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                RealInputFormatter(centavos: true),
              ],
              validator: (text) {
                if (text.isEmpty) {
                  return 'Campo obrigatório!';
                } else if (double.tryParse(text) == null) {
                  return 'Utilize valores válidos!';
                } else {
                  return null;
                }
              },
              onSaved: (price) {},
            ),
            Container(
              height: 50,
              child: RaisedButton(
                color: Colors.green,
                child: Text(
                  'Enviar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  getAddressFromAPI('57.036-810');

                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
