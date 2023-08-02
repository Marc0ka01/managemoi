import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:managemoi_mobile_app/components/soumission_form.dart';
import 'package:url_launcher/url_launcher.dart';

final String url = "https://youtube.com/";
void _launchURL() async {
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Impossible de lancer l\'URL $url';
  }
}

Widget modalMissionDetails() => DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: .5,
      maxChildSize: .9,
      builder: (context, scrollController) => Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 1,
          controller: scrollController,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Détails de la mission',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(1, 41, 112, 1),
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 20),
                Text(
                  'N°',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(1, 41, 112, 0.6),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '1',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(68, 68, 68, 1),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Titre de la mission',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(1, 41, 112, 0.6),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Instagram',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(68, 68, 68, 1),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Libelle',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(1, 41, 112, 0.6),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam libero nibh, condimentum vel ipsum ac, efficitur commodo dolor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Cras vitae est porta, mollis quam ac, tempus urna. Proin non massa nec massa sodales ornare.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(68, 68, 68, 1),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Lien',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(1, 41, 112, 0.6),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: _launchURL,
                  child: Text(
                    url,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent[700],
                        decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Montant',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(1, 41, 112, 0.6),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '10 FCFA',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(68, 68, 68, 1),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Date début',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(1, 41, 112, 0.6),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '2023-07-07',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(68, 68, 68, 1),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Date fin',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(1, 41, 112, 0.6),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '2023-07-10',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(68, 68, 68, 1),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Quota',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(1, 41, 112, 0.6),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '10',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(68, 68, 68, 1),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Soumission',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(1, 41, 112, 0.6),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '0',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(68, 68, 68, 1),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await showFormSubmit(context);
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0, minimumSize: Size(100, 40)),
                  child: Text(
                    'Soumission',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
