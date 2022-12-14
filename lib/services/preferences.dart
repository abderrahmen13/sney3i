import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snay3i/models/adress.dart';
import 'dart:convert';

import 'package:snay3i/models/proffessionel.dart';

class LocalPreferences {
  void setIntValue(String key, int value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(key, value);
    } catch (e) {
      if (kDebugMode) {
        print('ERROR SET INT PREFERENCES');
      }
    }
  }

  Future<int?> getIntValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getInt(key);
    } catch (e) {
      return null;
    }
  }

  void setStringListValue(String key, List<String> value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(key, value);
    } catch (e) {
      if (kDebugMode) {
        print('ERROR SET STRING LIST PREFERENCES');
      }
    }
  }

  Future<List<String>?> getStringListValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getStringList(key);
    } catch (e) {
      return null;
    }
  }

  void setBoolValue(String key, bool value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(key, value);
    } catch (e) {
      if (kDebugMode) {
        print('ERROR SET BOOL PREFERENCES');
      }
    }
  }

  Future<bool> getBoolValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getBool(key) ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getStringValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString(key);
    } catch (e) {
      return null;
    }
  }

  void setStringValue(String key, String value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    } catch (e) {
      if (kDebugMode) {
        print('ERROR SET STRING PREFERENCES');
      }
    }
  }

  Future<bool> setAdress(Adress adress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String s = json.encode(adress.toJson());
      prefs.setString('adress', s);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
        print('-- FAILED TO SAVE ADRESS --');
      }
      return false;
    }
  }

  Future<Adress?> getAdress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? p = prefs.getString('adress');
      Map? s = json.decode(p!);
      Adress adress = Adress.fromJson(s);
      return adress;
    } catch (e) {
      if (kDebugMode) {
        print(e);
        print('-- FAILED TO GET ADRESS --');
      }
      return null;
    }
  }

  Future<bool> setUser(Proffessionel profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String s = json.encode(profile.toJson());
      prefs.setString('user', s);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
        print('-- FAILED TO SAVE USER --');
      }
      return false;
    }
  }

  Future<Proffessionel?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? p = prefs.getString('user');
      Map? s = json.decode(p!);
      Proffessionel profile = Proffessionel.fromJson(s);
      return profile;
    } catch (e) {
      if (kDebugMode) {
        print(e);
        print('-- FAILED TO GET USER --');
      }
      return null;
    }
  }

  Future<bool> ifExist(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      bool x = prefs.containsKey(key);
      return x;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final success = await prefs.remove(key);
      return success;
    } catch (e) {
      if (kDebugMode) {
        print('ERROR REMOVING KEY');
      }
      return false;
    }
  }
}

LocalPreferences preferences = LocalPreferences();
