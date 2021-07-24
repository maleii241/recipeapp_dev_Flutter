import 'dart:convert';
import 'package:flutter_smart_home_ui/widgets/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "20", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "2355700046msh570a9b48236e3d6p18d926jsn3445393548c7",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}