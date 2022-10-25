import 'dart:async';
import 'package:snay3i/models/proffessionel.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  Proffessionel profile = Proffessionel();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 10), () async {
      var pr = await preferences.getUser();
      if (pr != null) {
        setState(() {
          profile = pr;
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
            AppLocalizations.of(context)!.personal_details,
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
                  title: Text(AppLocalizations.of(context)!.your_Full_name),
                  trailing: Text("${profile.firstname}",
                      style: TextStyle(color: Colors.grey.shade600)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                color: Colors.white,
                child: ListTile(
                  title: Text(AppLocalizations.of(context)!.birthday),
                  trailing: Text("${profile.birthday}",
                      style: TextStyle(color: Colors.grey.shade600)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                color: Colors.white,
                child: ListTile(
                  title: Text(AppLocalizations.of(context)!.address),
                  trailing: Text("${profile.adress}",
                      style: TextStyle(color: Colors.grey.shade600)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                color: Colors.white,
                child: ListTile(
                  title: const Text("phone"),
                  trailing: Text("${profile.phone}",
                      style: TextStyle(color: Colors.grey.shade600)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                color: Colors.white,
                child: ListTile(
                  title: const Text("CIN"),
                  trailing: Text("${profile.cin}",
                      style: TextStyle(color: Colors.grey.shade600)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                color: Colors.white,
                child: ListTile(
                  title: Text(AppLocalizations.of(context)!.your_email),
                  trailing: Text("${profile.email}",
                      style: TextStyle(color: Colors.grey.shade600)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                color: Colors.white,
                child: ListTile(
                  title: const Text("status"),
                  trailing: Text("${profile.status}",
                      style: TextStyle(color: Colors.grey.shade600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
