import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:managemoi_mobile_app/views/mission_details.dart';

class Mission extends StatelessWidget {
  const Mission({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle =
        ElevatedButton.styleFrom(elevation: 0, minimumSize: Size(327, 40));
    String truncateText(String text, int maxLength) {
      if (text.length <= maxLength) {
        return text;
      } else {
        return '${text.substring(0, maxLength)}...';
      }
    }

    ;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 19),
          height: 262,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1.0, color: const Color.fromRGBO(245, 245, 245, 1)),
          ),
          child: Column(
            children: [
              Image.asset(
                'images/rs.jpg',
                fit: BoxFit.cover,
                height: 100,
                width: 400,
              ),
              Container(
                width: 400,
                height: 160,
                padding: const EdgeInsets.only(
                    top: 30.0, left: 15.0, bottom: 10.0, right: 15.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(96, 158, 158, 158),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Instagram',
                      style: TextStyle(
                        fontSize: 19,
                        color: Color.fromRGBO(1, 41, 112, 1),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      truncateText(
                          'lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam libero nibh, condimentum vel ipsum ac, efficitur commodo dolor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Cras vitae est porta, mollis quam ac, tempus urna. Proin non massa nec massa sodales ornare.',
                          40),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(68, 68, 68, 1),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => modalMissionDetails()),
                      child: const Text('Faire la mission'),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
