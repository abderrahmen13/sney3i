import 'dart:convert';

import 'package:snay3i/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:snay3i/models/proffessionel.dart';

class CategoryRepo {
  Future<List<Category>> getCategory() async {
    List<Category> categoryList = [];
    var rep =
        await http.get(Uri.parse('https://sney3i.epsrd.com/api/category'));
    for (final iter in jsonDecode(rep.body)) {
      categoryList.add(Category.fromJson(iter));
    }
    return categoryList;
  }

  Future<List<Proffessionel>> getCategoryProfs(int id) async {
    List<Proffessionel> categoryProfsList = [];
    var rep = await http
        .get(Uri.parse('https://sney3i.epsrd.com/api/category_prof/$id'));
    try {
      if (rep.body.length > 10) {
        for (final iter in jsonDecode(rep.body)) {
          categoryProfsList.add(Proffessionel.fromJson(iter[0]));
        }
      }
    } catch (e) {
      print(e);
    }
    return categoryProfsList;
  }
}

CategoryRepo categoryRepo = CategoryRepo();
