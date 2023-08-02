import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cardMission(String titreMission, String descMission, int missionId) =>
    Container(
      height: 81,
      width: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(image: AssetImage('images/rs.jpg')),
      ),
    );
