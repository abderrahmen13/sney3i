import 'dart:convert';

import 'package:snay3i/models/adress.dart';
import 'package:http/http.dart' as http;

class AdressRepo {
  Future<List<Adress>> getAdress() async {
    List<Adress> adressList = [];
    var rep =
        await http.get(Uri.parse('https://sney3i.aliretshop.com/api/adress'));
    for (final iter in jsonDecode(rep.body)) {
      adressList.add(Adress.fromJson(iter));
    }
    return adressList;
  }
}

AdressRepo adressRepo = AdressRepo();
