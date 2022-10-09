//import 'package:bottom_nav_bar/persistent-tab-view.dart';
import 'dart:async';

import 'package:snay3i/models/proffessionel.dart';
import 'package:snay3i/screens/home_screen/diary.dart';
import 'package:snay3i/screens/me/me.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:snay3i/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snay3i/screens/favorite_screen/favorite_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({Key? key}) : super(key: key);

  @override
  _BottomNavViewState createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  late PersistentTabController _controller;
  Proffessionel profile = Proffessionel();

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    Timer(const Duration(milliseconds: 10), () async {
      Proffessionel? pr = await preferences.getUser();
      if (pr != null) {
        setState(() {
          profile = pr;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _widgetOptions() {
    return [
      const Diary(),
      const FavoriteScreen(),
      const Me(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade700,
        icon: const Icon(
          CupertinoIcons.home,
        ),
        activeColorPrimary: mainColor0,
        title: (AppLocalizations.of(context)!.diary),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade700,
        icon: const Icon(
          CupertinoIcons.heart_circle,
        ),
        activeColorPrimary: mainColor0,
        title: (AppLocalizations.of(context)!.favorite),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade700,
        icon: const Icon(
          Icons.account_circle_outlined,
        ),
        activeColorPrimary: mainColor0,
        title: (AppLocalizations.of(context)!.me),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _widgetOptions(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
