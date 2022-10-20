import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:snay3i/models/favori.dart';
import 'package:snay3i/models/proffessionel.dart';
import 'package:snay3i/repo/favori_repo.dart';
import 'package:snay3i/screens/home_screen/widgets/list_items.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:snay3i/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteState();
}

class _FavoriteState extends State<FavoriteScreen> {
  Proffessionel? profile = Proffessionel();
  List<Favori> favoriList = [];

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1), () async {
      Proffessionel? profilee = await preferences.getUser();
      if (profilee != null) {
        List<Favori> favoriListt = await favoriRepo.getFavoriList(profilee.id!);
        setState(() {
          profile = profilee;
          favoriList = favoriListt;
        });
      }
    });
  }

  @override
  void dispose() {
    preferences.removeKey('adress');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade200,
          title: Text(
            AppLocalizations.of(context)!.favorite,
            style: styleTitle17,
          ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: RefreshIndicator(
            color: Colors.deepPurpleAccent,
            onRefresh: () async {
              List<Favori> favoriListt =
                  await favoriRepo.getFavoriList(profile!.id!);
              setState(() {
                favoriList = favoriListt;
              });
            },
            child: favoriList.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          CupertinoIcons.heart_fill,
                          size: 105,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 250,
                          child: Text(
                            AppLocalizations.of(context)!
                                .you_dont_have_any_Favorite_recipe_yet,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, i) {
                      final data = favoriList[i];
                      //final data = Favori.fromJson(info);
                      return ListItem(proffessionel: data.person!);
                    },
                    itemCount: favoriList.length),
          ),
        ),
      ),
    );
  }
}
