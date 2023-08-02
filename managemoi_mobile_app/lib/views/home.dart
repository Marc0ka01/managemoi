import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:managemoi_mobile_app/components/card_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          CardHome(
            text_card: 'Missions effectuées',
            nbr_card: '0',
            icon_card: Icons.task_outlined,
            color_icon: Color.fromRGBO(65, 84, 241, 1),
            back_icon: Color.fromRGBO(246, 246, 254, 1),
          ),
          CardHome(
            text_card: 'Solde',
            nbr_card: '0 FCFA',
            icon_card: Icons.attach_money,
            color_icon: Color.fromRGBO(46, 202, 106, 1),
            back_icon: Color.fromRGBO(224, 248, 233, 1),
          ),
          CardHome(
            text_card: 'Message non lu',
            nbr_card: '0',
            icon_card: Icons.visibility_off_outlined,
            color_icon: Color.fromRGBO(255, 119, 29, 1),
            back_icon: Color.fromRGBO(255, 236, 223, 1),
          )
        ],
      ),
    );
  }
}
