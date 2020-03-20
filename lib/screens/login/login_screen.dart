import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 11),
                child: Text(
                  'Acessar com E-mail:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[900],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 4),
                child: Text(
                  'E-mail',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              StreamBuilder(
                builder: (context, snapshot) {
                  return TextField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 26, bottom: 4, left: 3),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Senha',
                        style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () {
                        /* Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => RecoveryScreen()),
                        ); */
                      },
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                builder: (context, snapshot) {
                  return TextField(
                    autocorrect: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}