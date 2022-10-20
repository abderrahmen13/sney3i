import 'package:snay3i/models/category.dart';
import 'package:snay3i/screens/home_screen/category_profiles.dart';
import 'package:flutter/material.dart';
import 'package:snay3i/style.dart';

class SubCategory extends StatefulWidget {
  final Category category;
  const SubCategory({Key? key, required this.category}) : super(key: key);

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
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
    final width = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          bottom: PreferredSize(
              child: SizedBox(
                width: width - 40,
                child: Column(
                  children: [
                    Image.network(
                      'https://sney3i.epsrd.com/icon/${widget.category.icon}',
                      width: 120,
                      height: 120,
                    ),
                    Text(
                      widget.category.name.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const Text("")
                  ],
                ),
              ),
              preferredSize: const Size.fromHeight(160)),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: const Color.fromARGB(87, 233, 128, 252),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: RefreshIndicator(
            color: Colors.deepPurpleAccent,
            onRefresh: () async {},
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Wrap(
                  children: [
                    ...widget.category.subCategoryItems!.map(
                      (item) => InkWell(
                        onTap: (() {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  CategoyProfiles(subcategory: item),
                            ),
                          );
                        }),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 5, left: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          decoration: const BoxDecoration(
                              color: colorWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: SizedBox(
                            width: 90,
                            height: 155,
                            child: Column(
                              children: [
                                Image.network(
                                  'https://sney3i.epsrd.com/icon/${item.icon}',
                                  width: 90,
                                  height: 120,
                                ),
                                Text(
                                  item.name.toString(),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
