import 'package:flutter/material.dart';
import 'package:managemoi_mobile_app/views/connect/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

enum SingingCharacter { M, F }

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // You can define your data variables here
  String name = '';
  String contact = '';
  String email = '';
  DateTime dateDeNaissance = DateTime.now();
  SingingCharacter? _sexe = SingingCharacter.M;
  String? ville;
  String quartier = '';
  String password = '';
  bool termsAccepted = false;

  // You can define your list of cities here, example:
  List<String> villesTriees = ['City 1', 'City 2', 'City 3'];

  void inscription() {
    if (_formKey.currentState!.validate()) {
      // Perform the registration logic here
      // For example, you can submit the data to an API or perform local registration
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            'Inscrivez-vous',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(1, 41, 112, 1),
                                fontSize: 20),
                          ),
                          SizedBox(height: 30),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // nom complet
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Nom complet'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'S\'il vous plaît, entrez votre nom complet!';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                ),
                                // nom complet

                                // contact
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      contact = value;
                                    });
                                  },
                                  maxLength: 10,
                                  keyboardType: TextInputType.phone,
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
                                    prefixText: '+225',
                                  ),
                                ),
                                // end contact

                                // email
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration:
                                      const InputDecoration(labelText: 'Email'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'S\'il vous plaît, entrez votre nom email!';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                ),
                                // end email

                                // date de naissance
                                TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                      labelText: 'Date de naissance'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'S\'il vous plaît, entrez votre date de naissance!';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                ),
                                // end date de naissance

                                // sexe
                                Row(
                                  children: [
                                    const Text('Sexe : '),
                                    const SizedBox(width: 20),
                                    Radio<SingingCharacter>(
                                      value: SingingCharacter.M,
                                      groupValue: _sexe,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _sexe = value;
                                        });
                                      },
                                    ),
                                    const Text('M'),
                                    const SizedBox(width: 20),
                                    Radio<SingingCharacter>(
                                      value: SingingCharacter.F,
                                      groupValue: _sexe,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _sexe = value;
                                        });
                                      },
                                    ),
                                    const Text('F'),
                                  ],
                                ),

                                // end sexe

                                // ville
                                DropdownButtonFormField<String>(
                                  decoration:
                                      InputDecoration(labelText: 'Ville'),
                                  value: ville,
                                  items: villesTriees.map((ville) {
                                    return DropdownMenuItem<String>(
                                      value: ville,
                                      child: Text(ville),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Entrez votre ville de résidence!';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      ville = value;
                                    });
                                  },
                                ),
                                // end ville

                                // quartier
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                      labelText: 'Quartier'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'S\'il vous plaît, entrez votre quartier!';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      quartier = value;
                                    });
                                  },
                                ),
                                // end quartier

                                // mot de passe
                                TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: 'Mot de passe'),
                                  validator: (value) {
                                    if (value!.length < 8) {
                                      return 'S\'il vous plaît entrez un mot de passe d\'au moins 8 caractères!';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: Text(
                                      'Je suis d\'accord et j\'accepte les terms and conditions *'),
                                  value: termsAccepted,
                                  onChanged: (value) {
                                    setState(() {
                                      termsAccepted = value!;
                                    });
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0, minimumSize: Size(327, 40)),
                                  onPressed: loading ? null : inscription,
                                  child: loading
                                      ? SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(),
                                        )
                                      : Text('Créer un compte'),
                                ),

                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('J\'ai déjà un compte? '),
                                    ),
                                    SizedBox(width: 5),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Login(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Inscrivez-vous !',
                                        style: TextStyle(
                                            color: Colors.blueAccent[700],
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
