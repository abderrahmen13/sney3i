import 'dart:convert';

import 'package:snay3i/models/proffessionel.dart';
import 'package:http/http.dart' as http;
import 'package:snay3i/models/rating.dart';

class UserRepo {
  Future<Proffessionel?> getUserByEmail(String email) async {
    var rep = await http.post(Uri.parse('https://sney3i.epsrd.com/api/profile'),
        body: {"user_type": "client", "type": "email", "id": email});
    return Proffessionel.fromJson(jsonDecode(rep.body)['user']);
  }

  Future<List<Proffessionel>> getProfs() async {
    List<Proffessionel> profsList = [];
    var rep = await http.get(Uri.parse('https://sney3i.epsrd.com/api/profs'));
    for (final iter in jsonDecode(rep.body)) {
      profsList.add(Proffessionel.fromJson(iter));
    }
    return profsList;
  }

  Future<Rating> getProfRating(int id) async {
    var rep =
        await http.get(Uri.parse('https://sney3i.epsrd.com/api/raiting/$id'));
    print(rep.body);
    if (rep.body.isNotEmpty) {
      return Rating.fromJson(jsonDecode(rep.body));
    } else {
      return Rating(rating: "0");
    }
  }
}

UserRepo userRop = UserRepo();
