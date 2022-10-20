import 'dart:async';
import 'package:snay3i/models/proffessionel.dart';
import 'package:snay3i/screens/language.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Proffessionel profile = Proffessionel();
  String language = "English";

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 10), () async {
      String? lang = await preferences.getStringValue('language');
      var pr = await preferences.getUser();
      if (pr != null) {
        setState(() {
          profile = pr;
          if (lang == "fr") {
            language = "Français";
          } else if (lang == "de") {
            language = "Deutsh";
          } else if (lang == "es") {
            language = "Español";
          } else if (lang == "pt") {
            language = "Português";
          } else if (lang == "ru") {
            language = "Pусский";
          }
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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            AppLocalizations.of(context)!.account,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                color: Colors.white,
                child: ListTile(
                    minLeadingWidth: 10,
                    title: Text(AppLocalizations.of(context)!.language),
                    leading: const Icon(Icons.language),
                    trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(language,
                            style: TextStyle(color: Colors.grey.shade600)),
                        const Text('  '),
                        const Icon(Icons.arrow_forward_ios, size: 15)
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Language(
                              inSettings: true,
                            ),
                          ));
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                color: Colors.white,
                child: ListTile(
                    minLeadingWidth: 10,
                    title:
                        Text(AppLocalizations.of(context)!.delete_my_account),
                    leading: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                    onTap: () {
                      // ...
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
