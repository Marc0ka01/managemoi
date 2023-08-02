import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Fermer'),
                    ),
                  ],
                  title: const Text('Message'),
                  contentPadding: EdgeInsets.all(20.0),
                  content:
                      const Text('Ceci un test ! Yeah un test ! Yeah Yeah'),
                ));
      },
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Mon nom',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  'Message',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Text('aujourdhui'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
