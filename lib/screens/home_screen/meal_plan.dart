import 'package:cached_network_image/cached_network_image.dart';
import 'package:snay3i/models/proffessionel.dart';
import 'package:snay3i/services/validations.dart';
import 'package:snay3i/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MealPlan extends StatefulWidget {
  const MealPlan({Key? key}) : super(key: key);

  @override
  State<MealPlan> createState() => _MealPlanState();
}

class _MealPlanState extends State<MealPlan> {
  Proffessionel profile = Proffessionel();
  DateTime today = validations.convertDateTimeToDate(DateTime.now());
  DateTime todayDate = validations.convertDateTimeToDate(DateTime.now());
  bool recipes = false;
  bool ingredients = true;
  int countDiets = 1;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          bottom: PreferredSize(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: const Icon(
                              CupertinoIcons.arrowtriangle_left_circle),
                          onPressed: () async {
                            
                          }),
                      InkWell(
                        onTap: () async {
                          DateTime? day = await showDatePicker(
                            
                              errorInvalidText: AppLocalizations.of(context)!.date_out_of_range,
                              context: context,
                              initialDate: today,
                              firstDate: today.add(const Duration(days: -30)),
                              lastDate: today.add(const Duration(days: 30)));
                          if (day != null) {
                            
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.calendar_today, size: 20),
                            Text(today == todayDate
                                ? " " + AppLocalizations.of(context)!.today
                                : today ==
                                        todayDate.add(const Duration(days: -1))
                                    ? " " +
                                        AppLocalizations.of(context)!.yesterday
                                    : today ==
                                            todayDate
                                                .add(const Duration(days: 1))
                                        ? " " +
                                            AppLocalizations.of(context)!
                                                .tomorrow
                                        : " ${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)}"),
                          ],
                        ),
                      ),
                      IconButton(
                          icon: const Icon(
                              CupertinoIcons.arrowtriangle_right_circle),
                          onPressed: () async {
                            
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: width / 2 - 20,
                        decoration: BoxDecoration(
                            color:
                                !recipes ? Colors.grey.shade200 : Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(10))),
                        child: ListTile(
                          dense: true,
                          selectedColor: Colors.green,
                          title: Text(AppLocalizations.of(context)!.ingredients,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20)),
                          selected: !recipes,
                          onTap: () {
                            setState(() {
                              recipes = false;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: width / 2 - 20,
                        decoration: BoxDecoration(
                            color:
                                recipes ? Colors.grey.shade200 : Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(10))),
                        child: ListTile(
                          dense: true,
                          selectedColor: Colors.green,
                          title: Text(AppLocalizations.of(context)!.recipes,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20)),
                          selected: recipes,
                          onTap: () {
                            setState(() {
                              recipes = true;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
              preferredSize: const Size.fromHeight(100)),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey.shade200,
          title: Text(AppLocalizations.of(context)!.meal_Plan,
              style: styleTitle17),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: RefreshIndicator(
            color: Colors.green,
            onRefresh: () async {
              
            },
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getIngredientsRecipes(double width, String text,
      List ingList, Proffessionel recipeList, String fieldname) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: styleTitle177),
        SizedBox(
          height: recipes ? 250 : 210,
          child: recipes
              ? Container(
                  width: width - 40,
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
                      InkWell(
                        onTap: () {
                          
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Container(
                                height: 175,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(10)),
                                    image: const DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            "recipeList.image!"),
                                        fit: BoxFit.cover))),
                            Container(
                                padding: const EdgeInsets.all(10),
                                width: width - 40,
                                color: Colors.black38,
                                child: Text("recipeList.title!",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: styleTitle14)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                              InkWell(
                                onTap: () async {
                                  
                                },
                                child: Column(
                                  children: [
                                    const Icon(Icons.swap_horiz_outlined),
                                    Text(AppLocalizations.of(context)!.swap)
                                  ],
                                ),
                              ),
                            InkWell(
                              onTap: () async {
                                
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.add_task_rounded,
                                    color:  Colors.green
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.track,
                                    style: const TextStyle( color: Colors.green),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  // store this controller in a State to save the carousel scroll position
                  children: [
                    ...ingList.map((item) {
                      return Container(
                        width: 170,
                        margin: const EdgeInsets.only(top: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade400,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(item.name.toString(),
                                          style: styleStylo,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center)),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        item.category.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                      )),
                                ],
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => Material(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 20),
                                          Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Text(
                                              item.name.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child:
                                                  Text("(${item.category})")),
                                          const SizedBox(height: 40),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                        .calories +
                                                    ": ${item.calorie!.toStringAsFixed(1)}k",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                        .protein +
                                                    ": ${item.protein!.toStringAsFixed(1)}g",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                        .fat +
                                                    ": ${item.fat!.toStringAsFixed(1)}g",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                        .carbohydrates +
                                                    ": ${item.carbohydrate!.toStringAsFixed(1)}g",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                        .calcium +
                                                    ": ${item.calcium!.toStringAsFixed(1)}k",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                        .dietary_Fiber +
                                                    ": ${item.dietaryFiber!.toStringAsFixed(1)}g",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                        .iron +
                                                    ": ${item.iron!.toStringAsFixed(1)}k",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                        .sodium +
                                                    ": ${item.sodium!.toStringAsFixed(1)}g",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                        .vitamin_A +
                                                    ": ${item.vitaminA!.toStringAsFixed(1)}k",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                        .vitamin_C +
                                                    ": ${item.vitaminC!.toStringAsFixed(1)}g",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                        .vitamin_B1 +
                                                    ": ${item.vitaminB1!.toStringAsFixed(1)}k",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                        .vitamin_B2 +
                                                    ": ${item.vitaminB2!.toStringAsFixed(1)}g",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  if (!item.eaten!)
                                    InkWell(
                                      onTap: () async {
                                        
                                      },
                                      child: Column(
                                        children: [
                                          const Icon(Icons.swap_horiz_outlined),
                                          Text(AppLocalizations.of(context)!
                                              .swap)
                                        ],
                                      ),
                                    ),
                                  InkWell(
                                    onTap: () async {
                                      
                                    },
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.add_task_rounded,
                                          color: item.eaten!
                                              ? Colors.green
                                              : Colors.black87,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.track,
                                          style: TextStyle(
                                              color: item.eaten!
                                                  ? Colors.green
                                                  : Colors.black87),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    })
                  ],
                ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  showSnackBar(String status, BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor:
          status == "ok" ? Colors.green.shade100 : Colors.red.shade100,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(status == "ok" ? Icons.check : Icons.warning_amber_rounded,
                color: status == "ok" ? Colors.green : Colors.red, size: 30),
            const SizedBox(width: 20),
            Expanded(
              child: Text(text, style: const TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    ));
  }
}
