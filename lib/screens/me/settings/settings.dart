import 'package:firebase_auth/firebase_auth.dart';
import 'package:snay3i/screens/authentification/login.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

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
            AppLocalizations.of(context)!.settings,
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
                    title: Text(AppLocalizations.of(context)!.account),
                    leading: const Icon(Icons.person),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                    onTap: () {}),
              ),
              Container(
                margin: const EdgeInsets.only(top: 3),
                color: Colors.white,
                child: ListTile(
                    minLeadingWidth: 10,
                    title: Text(AppLocalizations.of(context)!.notification),
                    leading: const Icon(Icons.notifications),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                    onTap: () {}),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                color: Colors.white,
                child: ListTile(
                    minLeadingWidth: 10,
                    title: Text(AppLocalizations.of(context)!.personal_details),
                    leading: const Icon(Icons.paste),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                    onTap: () {}),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                color: Colors.white,
                child: ListTile(
                    minLeadingWidth: 10,
                    title: Text(AppLocalizations.of(context)!.log_out),
                    leading: const Icon(Icons.logout),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                    onTap: () async {
                      preferences.setBoolValue('keeplogin', false);
                      preferences.removeKey('userEmail');
                      await preferences.removeKey('uid');
                      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                      await firebaseAuth.signOut();
                      Navigator.of(context, rootNavigator: true)
                          .pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const Login();
                          },
                        ),
                        (_) => false,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
