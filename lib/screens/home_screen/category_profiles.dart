import 'dart:async';

import 'package:snay3i/models/category.dart';
import 'package:snay3i/models/proffessionel.dart';
import 'package:snay3i/models/rating.dart';
import 'package:snay3i/repo/category_repo.dart';
import 'package:snay3i/repo/user_repo.dart';
import 'package:snay3i/screens/home_screen/proffessionel_profile.dart';
import 'package:flutter/material.dart';

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
      List<Proffessionel?> profsListt =
          await categoryRepo.getCategoryProfs(widget.subcategory.id!);
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
                      'https://sney3i.epsrd.com/icon/${widget.subcategory.icon}',
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      widget.subcategory.name.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const Text("")
                  ],
                ),
              ),
              preferredSize: const Size.fromHeight(140)),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.purpleAccent.shade100,
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
                  child: profsList.isNotEmpty
                      ? Wrap(
                          children: [
                            ...profsList.map((item) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: InkWell(
                                    onTap: (() {
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              ProfessionelProfile(
                                                  profile: item!),
                                        ),
                                      );
                                    }),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          'https://sney3i.epsrd.com/proffessionel/${item!.image}',
                                          width: 140,
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
                                            Text(item.adress.toString()),
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
                      : Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
