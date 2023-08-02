import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:managemoi_mobile_app/views/mission.dart';

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

Future<void> showFormSubmit(BuildContext context) async {
  final picker = ImagePicker();

  File? image1;
  File? image2;
  File? image3;

  return await showDialog(
    context: context,
    builder: (context) {
      // final TextEditingController _textEditingController =
      //     TextEditingController();
      // bool isChecked = false;

      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          key: _formKey,
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                        );

                        if (pickedFile != null) {
                          setState(() {
                            image1 = File(pickedFile.path);
                          });
                        }
                      },
                      child: const Text('Capture d\'écran 1'),
                    ),
                    if (image1 != null)
                      Image.file(
                        image1!,
                        width: 50,
                        height: 50,
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                        );

                        if (pickedFile != null) {
                          setState(() {
                            image2 = File(pickedFile.path);
                          });
                        }
                      },
                      child: const Text('Capture d\'écran 2'),
                    ),
                    if (image2 != null)
                      Image.file(
                        image2!,
                        width: 50,
                        height: 50,
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                        );

                        if (pickedFile != null) {
                          setState(() {
                            image3 = File(pickedFile.path);
                          });
                        }
                      },
                      child: const Text('Capture d\'écran 3'),
                    ),
                    if (image3 != null)
                      Image.file(
                        image3!,
                        width: 50,
                        height: 50,
                      ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Mission(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0, minimumSize: Size(100, 40)),
                  child: const Text(
                    'Soumission',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        );
      });
    },
  );
}
