import 'dart:async';

import 'package:snay3i/models/adress.dart';
import 'package:snay3i/models/category.dart';
import 'package:snay3i/models/proffessionel.dart';
import 'package:snay3i/models/rating.dart';
import 'package:snay3i/repo/category_repo.dart';
import 'package:snay3i/repo/user_repo.dart';
import 'package:snay3i/screens/home_screen/proffessionel_profile.dart';
import 'package:flutter/material.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:snay3i/style.dart';

class CategoyProfiles extends StatefulWidget {
  final Category subcategory;
  const CategoyProfiles({Key? key, required this.subcategory})
      : super(key: key);

  @override
  State<CategoyProfiles> createState() => _CategoyProfilesState();
}

class _CategoyProfilesState extends State<CategoyProfiles> {
  List<Proffessionel?> profsList = [];

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1), () async {
      Adress? adress = await preferences.getAdress();
      List<Proffessionel?> profsListt;
      if (adress == null) {
        profsListt =
            await categoryRepo.getCategoryProfs(widget.subcategory.id!);
      } else {
        profsListt = await categoryRepo.getCategoryProfsbyAdress(
            widget.subcategory.id!, adress.name.toString());
      }
      if (profsListt.isNotEmpty) {
        for (var item in profsListt) {
          Rating rating = await userRop.getProfRating(item!.id!);
          item.rating = rating;
        }
      }
      setState(() {
        profsList = profsListt;
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
          automaticallyImplyLeading: true,
          bottom: PreferredSize(
              child: SizedBox(
                width: width - 40,
                child: Column(
                  children: [
                    Image.network(
                      'https://sney3i.epsrd.com/public/icon/${widget.subcategory.icon}',
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      widget.subcategory.name.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const Text("")
                  ],
                ),
              ),
              preferredSize: const Size.fromHeight(140)),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: const Color.fromARGB(87, 233, 128, 252),
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
                profsList.isNotEmpty
                    ? Wrap(
                        children: [
                          ...profsList.map((item) => Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                decoration: const BoxDecoration(
                                    color: colorWhite,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: InkWell(
                                  onTap: (() {
                                    Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            ProfessionelProfile(
                                                profile: item!,
                                                subcategory:
                                                    widget.subcategory),
                                      ),
                                    );
                                  }),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          'https://sney3i.epsrd.com/public/proffessionel/${item!.image}',
                                          width: 120,
                                          height: 120,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item.firstname.toString() +
                                                " " +
                                                item.lastname.toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                  Icons.fmd_good_outlined),
                                              Text(item.adress.toString()),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  "${item.rating?.rating ?? 0}"),
                                              const Icon(Icons.star)
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      )
                    : const Center(
                        child: Text('Pas de proffesionells',
                            style: TextStyle(color: Colors.redAccent)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
