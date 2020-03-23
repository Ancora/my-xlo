import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myxlo/blocs/create_bloc.dart';
import 'package:myxlo/blocs/drawer_bloc.dart';
import 'package:myxlo/blocs/home_bloc.dart';
//import 'package:myxlo/api/api_postalcode.dart';
import 'package:myxlo/common/cep_field.dart';
import 'package:myxlo/common/custom_drawer/custom_drawer.dart';
import 'package:myxlo/models/ad.dart';
import 'package:myxlo/screens/create/widgets/hide_phone_widget.dart';
import 'package:myxlo/screens/create/widgets/images_field.dart';
import 'package:provider/provider.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CreateBloc _createBloc;

  Ad ad = Ad();

  @override
  void initState() {
    super.initState();
    _createBloc = CreateBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _createBloc?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inserir Anúncio'),
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: StreamBuilder<CreateState>(
            stream: _createBloc.outState,
            builder: (context, snapshot) {
              if (snapshot.data == CreateState.LOADING) {
                return Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blueGrey,
                      ),
                      strokeWidth: 5,
                    ),
                  ),
                );
              }
              return ListView(
                children: <Widget>[
                  ImagesField(
                    onSaved: (images) {
                      ad.images = images;
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
                    onSaved: (t) {
                      ad.title = t;
                    },
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
                    onSaved: (d) {
                      ad.description = d;
                    },
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
                    onSaved: (a) {
                      ad.address = a;
                    },
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
                      } else if (int.tryParse(getSanitizedText(text)) == null) {
                        return 'Utilize valores válidos!';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (p) {
                      ad.price = int.parse(getSanitizedText(p)) / 100;
                    },
                  ),
                  HidePhoneWidget(
                    onSaved: (h) {
                      ad.hidePhone = h;
                    },
                    initialValue: false,
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
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          Provider.of<HomeBloc>(context).addAd(ad);

                          final bool success = await _createBloc.saveAd(ad);

                          if (success) {
                            Provider.of<DrawerBloc>(context).setPage(0);
                          }
                        }
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  String getSanitizedText(String text) {
    return text.replaceAll(RegExp(r'[^\d]'), '');
  }
}
