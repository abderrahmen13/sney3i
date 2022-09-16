import 'dart:async';

import 'package:snay3i/models/profile.dart';
import 'package:snay3i/repo/user_repo.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:snay3i/services/validations.dart';
import 'package:snay3i/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Diary extends StatefulWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  late String uid;
  Profile profile = Profile(water: 2.75);
  DateTime today = validations.convertDateTimeToDate(DateTime.now());
  DateTime todayDate = validations.convertDateTimeToDate(DateTime.now());
  double caloryProccess = 0;
  double proteinProccess = 0;
  double carbsProccess = 0;
  double fatProccess = 0;
  int objectifWeight = 0;
  late TextEditingController controllerCurrentWeight;
  late TextEditingController controllerDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controllerCurrentWeight = TextEditingController();
    controllerDate = TextEditingController();
    controllerDate.text = today.toString().split(' ')[0];
  }

  @override
  void dispose() {
    controllerCurrentWeight.dispose();
    controllerDate.dispose();
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
          bottom: PreferredSize(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon:
                          const Icon(CupertinoIcons.arrowtriangle_left_circle),
                      onPressed: () async {}),
                  InkWell(
                    onTap: () async {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.calendar_today, size: 20),
                        Text(today == todayDate
                            ? " " + AppLocalizations.of(context)!.today
                            : today == todayDate.add(const Duration(days: -1))
                                ? " " + AppLocalizations.of(context)!.yesterday
                                : today ==
                                        todayDate.add(const Duration(days: 1))
                                    ? " " +
                                        AppLocalizations.of(context)!.tomorrow
                                    : " ${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)}"),
                      ],
                    ),
                  ),
                  IconButton(
                      icon:
                          const Icon(CupertinoIcons.arrowtriangle_right_circle),
                      onPressed: () async {}),
                ],
              ),
              preferredSize: const Size.fromHeight(50)),
          actions: [
            IconButton(
                padding: const EdgeInsets.only(right: 10),
                onPressed: () {},
                icon: const Icon(Icons.chat))
          ],
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey.shade200,
          title: Text(AppLocalizations.of(context)!.diary, style: styleTitle17),
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
                if (today.millisecondsSinceEpoch <=
                    todayDate.millisecondsSinceEpoch)
                  const SizedBox(height: 30),
                if (today.millisecondsSinceEpoch <=
                    todayDate.millisecondsSinceEpoch)
                  Text(AppLocalizations.of(context)!.weight,
                      style: styleTitle177),
                if (today.millisecondsSinceEpoch <=
                    todayDate.millisecondsSinceEpoch)
                  Container(
                    margin: const EdgeInsets.only(top: 10),
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
                          minLeadingWidth: 5,
                          title: Text(
                              AppLocalizations.of(context)!.log_your_weight,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          leading: const Icon(Icons.monitor_weight_outlined),
                          trailing: const Icon(
                            Icons.check_circle_outline,
                            size: 20,
                            color: Colors.green,
                          ),
                          iconColor: mainColor0,
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => Material(
                                        child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .log_your_weight,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              const SizedBox(height: 40),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                color: Colors.grey.shade200,
                                                child: TextFormField(
                                                  controller:
                                                      controllerCurrentWeight,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    suffixText: profile.units ==
                                                            "Metric"
                                                        ? " kg"
                                                        : " lb",
                                                    labelText:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .current_weight,
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 3),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return AppLocalizations
                                                              .of(context)!
                                                          .current_weight_required;
                                                    } else {
                                                      bool numberValid =
                                                          RegExp(r'^[0-9]+$')
                                                              .hasMatch(
                                                                  value.trim());
                                                      if (!numberValid) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .only_numeric_characters;
                                                      }
                                                    }
                                                    profile.units == "Metric"
                                                        ? profile
                                                                .currentWeight =
                                                            int.parse(value)
                                                        : profile
                                                                .currentWeight =
                                                            (double.parse(
                                                                        value) /
                                                                    2.205)
                                                                .round();
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                color: Colors.grey.shade200,
                                                child: TextFormField(
                                                  readOnly: true,
                                                  onTap: () async {
                                                    DateTime? day = await showDatePicker(
                                                        errorInvalidText:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .date_out_of_range,
                                                        context: context,
                                                        initialDate: today,
                                                        firstDate: today.add(
                                                            const Duration(
                                                                days: -10)),
                                                        lastDate: todayDate);
                                                    if (day != null) {
                                                      controllerDate.text = day
                                                          .toString()
                                                          .split(' ')[0];
                                                    }
                                                  },
                                                  controller: controllerDate,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: "Date",
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 3),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return AppLocalizations
                                                              .of(context)!
                                                          .date_required;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors
                                                      .green, // background
                                                  onPrimary: Colors
                                                      .white, // foreground
                                                  onSurface: Colors.green,
                                                  minimumSize:
                                                      const Size.fromHeight(50),
                                                ),
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .save,
                                                  style: const TextStyle(
                                                      fontSize: 25),
                                                ),
                                              )
                                            ]),
                                      ),
                                    ))).then((value) {
                              setState(() {
                                if (validations
                                        .convertDateTimeToDate(DateTime.now())
                                        .toString()
                                        .split(' ')[0] ==
                                    controllerDate.text) {
                                  objectifWeight = profile.currentWeight! -
                                      profile.startingWeight!;
                                }
                                controllerCurrentWeight.text = "";
                                controllerDate.text =
                                    today.toString().split(' ')[0];
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 30),
                Text(AppLocalizations.of(context)!.nutrition,
                    style: styleTitle177),
                Container(
                  margin: const EdgeInsets.only(top: 10),
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
                          minLeadingWidth: 5,
                          title: Text(AppLocalizations.of(context)!.breakfast,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          leading: const Icon(Icons.free_breakfast_outlined),
                          trailing: const Icon(
                            Icons.add_circle_outline,
                            size: 20,
                            color: Colors.grey,
                          ),
                          iconColor: mainColor0,
                          onTap: () {}),
                      Container(
                        color: Colors.grey.shade200,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        height: 2,
                      ),
                      if (profile.mealsPerDay != 3)
                        ListTile(
                            minLeadingWidth: 5,
                            title: Text(AppLocalizations.of(context)!.snack1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            leading:
                                const Icon(Icons.breakfast_dining_outlined),
                            trailing: const Icon(
                              Icons.add_circle_outline,
                              size: 20,
                              color: Colors.grey,
                            ),
                            iconColor: mainColor0,
                            onTap: () {}),
                      if (profile.mealsPerDay != 3)
                        Container(
                          color: Colors.grey.shade200,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          height: 2,
                        ),
                      if (profile.mealsPerDay != 2)
                        ListTile(
                            minLeadingWidth: 5,
                            title: Text(AppLocalizations.of(context)!.lunch,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            leading: const Icon(Icons.lunch_dining_outlined),
                            trailing:  const Icon(
                                    Icons.add_circle_outline,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                            iconColor: mainColor0,
                            onTap: () {
                             
                            }),
                      if (profile.mealsPerDay != 2)
                        Container(
                          color: Colors.grey.shade200,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          height: 2,
                        ),
                      if (profile.mealsPerDay != 3 && profile.mealsPerDay != 4)
                        ListTile(
                            minLeadingWidth: 5,
                            title: Text(AppLocalizations.of(context)!.snack2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            leading:
                                const Icon(Icons.breakfast_dining_outlined),
                            trailing: const Icon(
                                    Icons.add_circle_outline,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                            iconColor: mainColor0,
                            onTap: () {
                              
                            }),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(AppLocalizations.of(context)!.water_balance,
                    style: styleTitle177),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
