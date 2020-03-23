import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myxlo/blocs/cep_bloc.dart';
import 'package:myxlo/models/address.dart';

class CepField extends StatefulWidget {
  final InputDecoration decoration;
  final FormFieldSetter<Address> onSaved;

  CepField({this.decoration, this.onSaved});

  @override
  _CepFieldState createState() => _CepFieldState();
}

class _CepFieldState extends State<CepField> {
  InputDecoration get decoration => widget.decoration;
  FormFieldSetter<Address> get onSaved => widget.onSaved;

  CepBloc cepBloc;

  @override
  void initState() {
    super.initState();
    cepBloc = CepBloc();
  }

  @override
  void dispose() {
    super.dispose();
    cepBloc?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CepBlocState>(
      initialData: CepBlocState(
        cepFieldState: CepFieldState.INITIALIZING,
      ),
      stream: cepBloc.outCep,
      builder: (context, snapshot) {
        if (snapshot.data.cepFieldState == CepFieldState.INITIALIZING) {
          return Container();
        } else {
          return Column(
            children: <Widget>[
              TextFormField(
                initialValue: snapshot.data.cep,
                decoration: decoration,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
                onSaved: (c) {
                  onSaved(snapshot.data.address);
                },
                onChanged: cepBloc.onChanged,
                validator: (c) {
                  switch (snapshot.data.cepFieldState) {
                    case CepFieldState.INITIALIZING:
                    case CepFieldState.INCOMPLETE:
                      return 'Campo obrigatório!';
                      break;
                    case CepFieldState.INVALID:
                      return 'CEP inválido!';
                      break;
                    case CepFieldState.VALID:
                      break;
                    default:
                  }
                  return null;
                },
              ),
              buildInformation(snapshot.data),
            ],
          );
        }
      },
    );
  }

  Widget buildInformation(CepBlocState blocState) {
    switch (blocState.cepFieldState) {
      case CepFieldState.INITIALIZING:
      case CepFieldState.INCOMPLETE:
        return Container();
        break;
      case CepFieldState.INVALID:
        return Container(
          height: 50,
          padding: const EdgeInsets.all(8),
          color: Colors.red.withAlpha(100),
          alignment: Alignment.center,
          child: Text(
            'CEP inválido!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.red[900],
            ),
          ),
        );
        break;
      case CepFieldState.VALID:
        final _address = blocState.address;
        return Container(
          height: 50,
          padding: const EdgeInsets.all(8),
          color: Colors.blue.withAlpha(150),
          alignment: Alignment.center,
          child: Text(
            'Localização: ${_address.place} - ${_address.district} - ${_address.city} - ${_address.federativeUnit}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blue[900],
            ),
          ),
        );
        break;
      default:
    }
    return Container();
  }
}
