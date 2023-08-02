import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:managemoi_mobile_app/components/withdrawal.dart';
import 'package:managemoi_mobile_app/main.dart';
import 'package:managemoi_mobile_app/views/home.dart';
import 'package:managemoi_mobile_app/views/message.dart';
import 'package:managemoi_mobile_app/views/mission.dart';
import 'package:managemoi_mobile_app/views/versement.dart';

class AppBarStatic extends StatefulWidget {
  const AppBarStatic({super.key});

  @override
  State<AppBarStatic> createState() => _AppBarStaticState();
}

class _AppBarStaticState extends State<AppBarStatic> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await withdrawal(context);
          },
          backgroundColor: const Color.fromRGBO(110, 4, 151, 1),
          child: const Icon(Icons.file_download_outlined),
        ),
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.warning_amber,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout_outlined),
            )
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(110, 4, 151, 1),
                Color.fromRGBO(36, 38, 181, 1),
                Color.fromRGBO(145, 20, 105, 1)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
          bottom: const TabBar(
            isScrollable: false,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(
                icon: Icon(Icons.home_outlined),
                text: 'Accueil',
              ),
              Tab(
                icon: Icon(Icons.task_outlined),
                text: 'Missions',
              ),
              Tab(
                icon: Icon(Icons.payments_outlined),
                text: 'Retrait',
              ),
              Tab(
                icon: Icon(Icons.message_outlined),
                text: 'Message',
              ),
            ],
          ),
          elevation: 10,
        ),
        body: const TabBarView(
          children: [
            Home(),
            Mission(),
            Versement(),
            Message(),
          ],
        ),
      ),
    );
  }
}
