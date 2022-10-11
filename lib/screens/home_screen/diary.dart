import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:snay3i/models/adress.dart';
import 'package:snay3i/models/category.dart';
import 'package:snay3i/models/proffessionel.dart';
import 'package:snay3i/repo/adress_repo.dart';
import 'package:snay3i/repo/category_repo.dart';
import 'package:snay3i/repo/user_repo.dart';
import 'package:snay3i/screens/home_screen/sub_category.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:snay3i/services/validations.dart';
import 'package:snay3i/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Diary extends StatefulWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  late String uid;
  Proffessionel? profile = Proffessionel();
  List<Adress> adressList = [];
  List<Proffessionel> profsList = [];
  List<Category> categoryList = [];
  Adress dropdownValue = Adress(id: 0, name: "Sousse");

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1), () async {
      List<Adress> adressListt = await adressRepo.getAdress();
      List<Proffessionel> profsListt = await userRop.getProfs();
      List<Category> categoryListt = await categoryRepo.getCategory();
      Proffessionel? profilee = await preferences.getUser();
      setState(() {
        adressList = adressListt;
        dropdownValue = adressList.first;
        profile = profilee;
        profsList = profsListt;
        categoryList = categoryListt;
      });
    });
  }

  @override
  void dispose() {
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
          bottom: PreferredSize(
              child: SizedBox(
                width: width - 40,
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Sélectionnez votre adresse',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.gps_fixed,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: adressList
                      .map((item) => DropdownMenuItem<Adress>(
                            value: item,
                            child: Text(
                              item.name!,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return "Veuillez sélectionner l'adresse.";
                    }
                  },
                  onChanged: (Adress? value) {
                    dropdownValue = value!;
                  },
                ),
              ),
              preferredSize: const Size.fromHeight(50)),
          actions: [
            IconButton(
                padding: const EdgeInsets.only(right: 10),
                onPressed: () {},
                icon: const Icon(Icons.chat))
          ],
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey.shade200,
          title: Text(AppLocalizations.of(context)!.diary, style: styleTitle17),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Marhbé ${profile?.firstname}",
                      style: const TextStyle(fontSize: 24),
                    ),
                    Text("Retrouvez plus de ${profsList.length} proffesionels")
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Wrap(
                    children: [
                      ...categoryList.map((item) => Padding(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                              onTap: (() {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        SubCategory(category: item),
                                  ),
                                );
                              }),
                              child: Column(
                                children: [
                                  Image.network(
                                    'https://sney3i.epsrd.com/icon/${item.icon}',
                                    width: 140,
                                    height: 140,
                                  ),
                                  Text(
                                    item.name.toString(),
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
