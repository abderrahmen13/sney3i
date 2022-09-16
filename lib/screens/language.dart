import 'dart:async';

import 'package:snay3i/main.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Language extends StatefulWidget {
  final bool? inSettings;
  const Language({this.inSettings, Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String language = "fr";
  late bool inSettings;

  @override
  void initState() {
    super.initState();
    inSettings = widget.inSettings ?? false;
    if (inSettings) {
      Timer(const Duration(milliseconds: 10), () async {
        String? lang = await preferences.getStringValue('language');
        setState(() {
          language = lang ?? "fr";
        });
      });
    }
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
          automaticallyImplyLeading: inSettings,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: !inSettings
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                    ),
                    Text(AppLocalizations.of(context)!.language_setup,
                        style: Theme.of(context).textTheme.headline5),
                  ],
                )
              : Text(AppLocalizations.of(context)!.language_setup,
                  style: Theme.of(context).textTheme.headline5),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !inSettings
                      ? Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .you_can_change_language_later,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                  Column(
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: RadioListTile(
                            activeColor: Colors.deepPurple,
                            title: const Text('Français'),
                            value: 'fr',
                            groupValue: language,
                            onChanged: (value) {
                              setState(() {
                                language = "fr";
                              });
                            },
                          )),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: RadioListTile(
                            activeColor: Colors.deepPurple,
                            title: const Text('English'),
                            value: 'en',
                            groupValue: language,
                            onChanged: (value) {
                              setState(() {
                                language = "en";
                              });
                            },
                          )),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          color: Colors.white,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple, // background
              onPrimary: Colors.white, // foreground
              onSurface: Colors.deepPurple,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              // Save locale language
              preferences.setStringValue('language', language);
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MyApp(lang: language);
                  },
                ),
                (_) => false,
              );
            },
            child: Text(
              AppLocalizations.of(context)!.save,
              style: const TextStyle(fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
