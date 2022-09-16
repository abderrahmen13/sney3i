import 'package:snay3i/screens/me/settings/settings.dart';
import 'package:snay3i/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Me extends StatefulWidget {
  const Me({Key? key}) : super(key: key);

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {

  @override
  void initState() {
    super.initState();
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
                        title: Text(AppLocalizations.of(context)!.goal,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        leading: const Icon(Icons.account_tree_rounded,
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
                        child: ListTile(
                            title: Text(
                                AppLocalizations.of(context)!.current_Goal +
                                    ":"),
                            subtitle: const Text("+10 kg",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30)),
                            textColor: Colors.black,
                            trailing: const Icon(Icons.badge, size: 50)),
                      ),
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
                            onPressed: () {},
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
