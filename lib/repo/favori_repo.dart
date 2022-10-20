import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:snay3i/models/favori.dart';

class FavoriRepo {
  Future<List<Favori>> getFavoriList(int userId) async {
    List<Favori> favoriList = [];
    var rep = await http.get(Uri.parse('https://sney3i.epsrd.com/api/favori_list/$userId'));
    for (final iter in jsonDecode(rep.body)) {
      favoriList.add(Favori.fromJson(iter));
    }
    return favoriList;
  }

  Future<List<Favori>> getFavoriListProfs(int userId, int profId) async {
    List<Favori> favoriList = [];
    var rep = await http.get(Uri.parse('https://sney3i.epsrd.com/api/favori_list/$userId/$profId'));
    for (final iter in jsonDecode(rep.body)) {
      favoriList.add(Favori.fromJson(iter));
    }
    return favoriList;
  }

  Future<bool> addFavori(String clientId, String proffessionelId) async {
    var rep =
        await http.post(
          Uri.parse('https://sney3i.epsrd.com/api/add_favori'), 
          body: {
            "client_id": clientId,
            "proffessionel_id": proffessionelId
          }
        );
    print(rep.body);
    return true;
  }

  Future<bool> deleteFavori(String clientId, String proffessionelId) async {
    var rep =
        await http.post(
          Uri.parse('https://sney3i.epsrd.com/api/remove_favori'), 
          body: {
            "client_id": clientId,
            "proffessionel_id": proffessionelId
          }
        );
    print(rep.body);
    return true;
  }
}

FavoriRepo favoriRepo = FavoriRepo();
