import 'package:flutter/material.dart';

GlobalKey<FormState> _formKey = GlobalKey<FormState>();
List<String> options = [
  'Option 1',
  'Option 2',
  'Option 3',
  // Ajoutez autant d'options que nécessaire
];

Future<void> withdrawal(BuildContext context) async {
  String? selectedOption;
  return await showDialog(
    context: context,
    builder: (context) {
      final TextEditingController _textEditingController =
          TextEditingController();
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            key: _formKey,
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _textEditingController,
                    validator: (value) {
                      return value!.isNotEmpty ? null : 'Invalid Field';
                    },
                    decoration: InputDecoration(hintText: 'Montant'),
                  ),
                  SizedBox(height: 10),
                  DropdownButton(
                    hint: Text('Mode de retrait'),
                    value: selectedOption,
                    onChanged: (newValue) {
                      // Cette fonction sera appelée lorsque l'utilisateur sélectionne une option
                      // et mettra à jour la variable selectedOption.
                      // La mise à jour de la variable déclenchera la reconstruction du widget.
                      // Vous pouvez ajouter ici une logique supplémentaire en fonction de la sélection.
                      // Par exemple, afficher un message ou effectuer une action en fonction de l'option choisie.
                      setState(() {
                        selectedOption = newValue;
                      });
                    },
                    items: options.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0
                    ),
                    onPressed: () {},
                    child: const Text('Valider'),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
