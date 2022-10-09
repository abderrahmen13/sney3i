import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:snay3i/models/proffessionel.dart';
import 'package:snay3i/screens/home_screen/widgets/list_items.dart';
import 'package:snay3i/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

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
        body: ValueListenableBuilder<Box>(
            valueListenable: Hive.box('Favorite').listenable(),
            builder: (context, box, child) {
              if (box.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        CupertinoIcons.heart_fill,
                        size: 105,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          AppLocalizations.of(context)!.you_dont_have_any_Favorite_recipe_yet,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowIndicator();
                  return true;
                },
                child: ListView.builder(
                    itemBuilder: (context, i) {
                      final info = box.getAt(i);
                      final data = Proffessionel.fromJson(info);
                      return ListItem(
                        proffessionel: Proffessionel (
                          uid: data.uid.toString(),
                          image: data.image!,
                          firstname: data.firstname.toString(),
                          phone: data.phone.toString(),
                          adress: data.adress.toString(),
                        ),
                      );
                    },
                    itemCount: box.length),
              );
            }),
      ),
    );
  }
}
