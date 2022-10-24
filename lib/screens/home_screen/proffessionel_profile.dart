import 'dart:async';

import 'package:snay3i/models/category.dart';
import 'package:snay3i/models/favori.dart';
import 'package:snay3i/models/proffessionel.dart';
import 'package:flutter/material.dart';
import 'package:snay3i/repo/favori_repo.dart';
import 'package:snay3i/repo/user_repo.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfessionelProfile extends StatefulWidget {
  final Proffessionel profile;
  final Category subcategory;
  const ProfessionelProfile(
      {Key? key, required this.profile, required this.subcategory})
      : super(key: key);

  @override
  State<ProfessionelProfile> createState() => _ProfessionelProfileState();
}

class _ProfessionelProfileState extends State<ProfessionelProfile> {
  List<Favori> favoriList = [];
  Proffessionel? me = Proffessionel();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1), () async {
      Proffessionel? profilee = await preferences.getUser();
      if (profilee != null) {
        List<Favori> favoriListt = await favoriRepo.getFavoriListProfs(
            profilee.id!, widget.profile.id!);
        setState(() {
          me = profilee;
          favoriList = favoriListt;
        });
      }
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
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://sney3i.epsrd.com/public/proffessionel/${widget.profile.image}',
                            width: 120,
                            height: 120,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.profile.firstname.toString() +
                                  " " +
                                  widget.profile.lastname.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.subcategory.name.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text("${widget.profile.rating?.rating ?? 0}"),
                                const Icon(Icons.star)
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.fmd_good_outlined),
                                Text(widget.profile.adress.toString()),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(widget.profile.sms.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const Text(
                              "Messages",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Text("0",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              "Vues profils",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Text("0",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              "Commentaires",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(widget.profile.calls.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const Text(
                              "Appels",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () async {
                            userRop.updateProfileSMS(
                                widget.profile.id!,
                                (int.parse(widget.profile.sms.toString()) + 1)
                                    .toString(),
                                widget.profile.calls.toString());
                            await launchUrl(Uri.parse(
                                'sms:${widget.profile.phone.toString()}'));
                            setState(() {
                              widget.profile.sms =
                                  (int.parse(widget.profile.sms.toString()) + 1)
                                      .toString();
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: const Icon(Icons.chat_outlined),
                          ),
                        ),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                              color: Colors.yellow.shade200,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: const Center(
                              child: Text("Ajouter une note",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ),
                        InkWell(
                          onTap: () async {
                            userRop.updateProfileSMS(
                                widget.profile.id!,
                                widget.profile.sms.toString(),
                                (int.parse(widget.profile.calls.toString()) + 1)
                                    .toString());
                            await launchUrl(Uri.parse(
                                'tel:${widget.profile.phone.toString()}'));
                            setState(() {
                              widget.profile.calls =
                                  (int.parse(widget.profile.calls.toString()) +
                                          1)
                                      .toString();
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: const Icon(Icons.call_outlined),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              preferredSize: const Size.fromHeight(260)),
          actions: [
            IconButton(
                padding: const EdgeInsets.only(right: 10),
                onPressed: () async {
                  if(favoriList.isEmpty) {
                    await favoriRepo.addFavori(me!.id.toString(), widget.profile.id.toString());
                    setState(() {
                      favoriList.add(Favori());
                    });
                  } else {
                    await favoriRepo.deleteFavori(me!.id.toString(), widget.profile.id.toString());
                    setState(() {
                      favoriList = [];
                    });
                  }
                  
                },
                icon: Icon(favoriList.isEmpty
                    ? Icons.thumb_up_alt_outlined
                    : Icons.thumb_up_alt)),
            IconButton(
                padding: const EdgeInsets.only(right: 10),
                onPressed: () {},
                icon: const Icon(Icons.share_outlined))
          ],
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
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
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
