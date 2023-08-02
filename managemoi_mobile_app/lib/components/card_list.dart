import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CardHome extends StatelessWidget {
  final String text_card;
  final String nbr_card;
  final IconData icon_card;
  final Color color_icon;
  final Color back_icon;
  const CardHome(
      {super.key,
      required this.text_card,
      required this.nbr_card,
      required this.icon_card,
      required this.color_icon,
      required this.back_icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(22, 233, 214, 214),
            blurRadius: 24,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromRGBO(187, 172, 172, 0.507))),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, top: 45.0, right: 16.0, bottom: 45.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text_card,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(1, 41, 112, 1),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: back_icon,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        icon_card,
                        color: color_icon,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    nbr_card,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(1, 41, 112, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
