import 'dart:async';

import 'package:snay3i/models/adress.dart';
import 'package:snay3i/models/proffessionel.dart';
import 'package:snay3i/repo/adress_repo.dart';
import 'package:snay3i/repo/user_repo.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:snay3i/services/validations.dart';
import 'package:flutter/material.dart';

class ProfessionelProfile extends StatefulWidget {
  final Proffessionel profile;
  const ProfessionelProfile({Key? key, required this.profile})
      : super(key: key);

  @override
  State<ProfessionelProfile> createState() => _ProfessionelProfileState();
}

class _ProfessionelProfileState extends State<ProfessionelProfile> {
  late String uid;
  Proffessionel? profile = Proffessionel();
  List<Adress> adressList = [];
  List<Proffessionel> profsList = [];
  Adress dropdownValue = Adress(id: 0, name: "Sousse");
  DateTime today = validations.convertDateTimeToDate(DateTime.now());
  DateTime todayDate = validations.convertDateTimeToDate(DateTime.now());
  double caloryProccess = 0;
  double proteinProccess = 0;
  double carbsProccess = 0;
  double fatProccess = 0;
  int objectifWeight = 0;
  late TextEditingController controllerCurrentWeight;
  late TextEditingController controllerDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controllerCurrentWeight = TextEditingController();
    controllerDate = TextEditingController();
    controllerDate.text = today.toString().split(' ')[0];
    Timer(const Duration(milliseconds: 1), () async {
      List<Adress> adressListt = await adressRepo.getAdress();
      List<Proffessionel> profsListt = await userRop.getProfs();
      Proffessionel? profilee = await preferences.getUser();
      setState(() {
        adressList = adressListt;
        dropdownValue = adressList.first;
        profile = profilee;
        profsList = profsListt;
      });
    });
  }

  @override
  void dispose() {
    controllerCurrentWeight.dispose();
    controllerDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey.shade200,
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: RefreshIndicator(
            color: Colors.green,
            onRefresh: () async {},
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Wrap(
                    children: [
                      ...['adressList', '15'].map((item) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: (() {}),
                              child: Column(
                                children: [
                                  Image.network(
                                    'https://sney3i.epsrd.com/icon/125487.png',
                                    width: 140,
                                  ),
                                  Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
