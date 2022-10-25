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
import 'package:snay3i/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Diary extends StatefulWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
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
    preferences.removeKey('adress');
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    isExpanded: true,
                    hint: Text(AppLocalizations.of(context)!.select_your_address,
                      style: const TextStyle(fontSize: 14),
                    ),
                    icon: const Icon(
                      Icons.fmd_good_outlined,
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
                    onChanged: (Adress? value) async {
                      dropdownValue = value!;
                      await preferences.setAdress(value);
                      List<Proffessionel> profsListt =
                          await userRop.getProfsByAdress(value.name.toString());
                      setState(() {
                        profsList = profsListt;
                      });
                    },
                  ),
                ),
              ),
              preferredSize: const Size.fromHeight(70)),
          // actions: [
          //   IconButton(
          //       padding: const EdgeInsets.only(right: 10),
          //       onPressed: () {},
          //       icon: const Icon(Icons.chat))
          // ],
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: const Color.fromARGB(87, 233, 128, 252),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: Text(AppLocalizations.of(context)!.diary, style: styleTitle17),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: RefreshIndicator(
            color: Colors.deepPurpleAccent,
            onRefresh: () async {},
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.welcome+" ${profile?.firstname}",
                      style: const TextStyle(fontSize: 24),
                    ),
                    Text(AppLocalizations.of(context)!.find_more+" ${profsList.length} "+AppLocalizations.of(context)!.professionals)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Wrap(
                    children: [
                      ...categoryList.map(
                        (item) => InkWell(
                          onTap: (() {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    SubCategory(category: item),
                              ),
                            );
                          }),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5, left: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            decoration: const BoxDecoration(
                                color: colorWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: SizedBox(
                              width: 90,
                              height: 155,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.network(
                                    'https://sney3i.epsrd.com/public/icon/${item.icon}',
                                    width: 90,
                                    height: 120,
                                  ),
                                  Text(
                                    item.name.toString(),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
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
