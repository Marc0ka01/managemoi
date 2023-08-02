import 'package:flutter/material.dart';
import 'package:managemoi_mobile_app/views/connect/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String contact = '';
  String password = '';
  bool loading = false;
  bool status = false;

  void validateNumber(String value) {
    loading = true;

    setState(() {
      status = true;
    });
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      // Add your form submission logic here
      // For example, you can send the data to a server.
      // Once the submission is complete, you can update the 'loading' variable.
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              width: 150,
            ),
            Container(
              width: 350,
              padding: EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(62, 172, 171, 171),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Connectez-vous',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(1, 41, 112, 1), fontSize: 20),
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            // Set the initial value
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              setState(() {
                                contact = value;
                              });
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length != 10) {
                                return 'Entrez un numéro valide svp.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Numero de téléphone',
                              border: OutlineInputBorder(),
                              prefixText: '+225',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            obscureText: true,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "S'il vous plaît entrez un mot de passe!";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Mot de passe',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: loading ? null : submitForm,
                            style: ElevatedButton.styleFrom(
                                elevation: 0, minimumSize: Size(327, 40)),
                            child: loading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : Text('Connexion'),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Je n\'ai pas de compte? '),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                Register();
                              },
                              child: Text(
                                'Créer un compte',
                                style: TextStyle(
                                    color: Colors.blueAccent[700],
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
