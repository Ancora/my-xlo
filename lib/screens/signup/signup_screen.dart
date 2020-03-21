import 'package:flutter/material.dart';
import 'package:myxlo/screens/signup/widgets/field_title.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        title: Text('Cadastrar'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            const FieldTitle(
              title: 'Apelido',
              subtitle: 'Como aparecerá em seus anúncios.',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Exemplo: A Rocha',
              ),
              validator: (text) {
                if (text.length < 6) {
                  return 'Apelido muito curto';
                } else {
                  return null;
                }
              },
            ),
            const FieldTitle(
              title: 'E-mail',
              subtitle: 'Enviaremos um e-mail de confirmação.',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              validator: (text) {
                const Pattern pattern =
                    r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";
                final RegExp regex = RegExp(pattern);
                if (text.isEmpty) {
                  return 'Campo obrigatório!';
                } else if (!regex.hasMatch(text)) {
                  return 'E-mail inválido!';
                } else {
                  return null;
                }
              },
            ),
            const FieldTitle(
              title: 'Senha',
              subtitle: 'Use letras, números e caracteres especiais.',
            ),
          ],
        ),
      ),
    );
  }
}
