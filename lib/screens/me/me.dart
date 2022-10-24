import 'dart:async';

import 'package:snay3i/models/proffessionel.dart';
import 'package:snay3i/screens/me/settings/personal_details.dart';
import 'package:snay3i/screens/me/settings/settings.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:snay3i/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Me extends StatefulWidget {
  const Me({Key? key}) : super(key: key);

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  Proffessionel? profile = Proffessionel();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1), () async {
      Proffessionel? profilee = await preferences.getUser();
      setState(() {
        profile = profilee;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          actions: [
            IconButton(
                padding: const EdgeInsets.only(right: 10),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Settings(),
                      ));
                },
                icon: const Icon(Icons.settings))
          ],
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey.shade200,
          title: Text(AppLocalizations.of(context)!.me, style: styleTitle17),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: RefreshIndicator(
            color: Colors.deepPurple,
            onRefresh: () async {},
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade400,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text("Détails du compte",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        leading: const Icon(Icons.account_box_outlined,
                            color: mainColor0),
                        iconColor: Colors.grey.shade300,
                      ),
                      Container(
                        color: Colors.grey.shade200,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        height: 2,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 248, 230, 245),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Image.network(
                          profile?.image != null
                              ? 'https://sney3i.epsrd.com/public${profile?.image}'
                              : 'https://sney3i.epsrd.com/public/icon/default.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Text(profile!.firstname.toString(),
                          style: const TextStyle(fontSize: 30)),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple, // background
                              onPrimary: Colors.white, // foreground
                              onSurface: Colors.deepPurple,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PersonalDetails(),
                                  ));
                            },
                            child: Text(
                                AppLocalizations.of(context)!.edit_my_profile,
                                style: const TextStyle(fontSize: 18))),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
