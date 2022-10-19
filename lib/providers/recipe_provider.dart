

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../models/recipe_model.dart';
import 'package:dio/dio.dart';


class Recipes with ChangeNotifier {

  bool _loading = false;
  List<Recipe> recipes = [];

  bool get loading => _loading;

  bool _popularLoading = false;
  List<Recipe> popularRecipes = [];
  bool get popularLoading => _popularLoading;






Future fetchRecipes() async {


  _loading = true;
  recipes.clear();
  String url = "https://datascienceplc.com/api/ds_her/v1/recipe/popular?page=1&per_page=15&category=bread";


  Dio dio = Dio();
  final response = await dio.get(url);

  // var result = jsonDecode(response.data);

  Recipe recipe;
  response.data["recipes"].forEach((el) async => {
    recipe = Recipe.fromJson(el),
    recipes.add(recipe),

  });




  _loading = false;
  notifyListeners();
}

Future fetchPopularRecipes() async {


  _popularLoading = true;
  String url = "https://datascienceplc.com/api/ds_her/v1/recipe/popular?page=1&per_page=15&category=desserts";


  Dio dio = Dio();
  final response = await dio.get(url);

  // var result = jsonDecode(response.data);

  Recipe recipe;
  response.data["recipes"].forEach((el) async => {
    recipe = Recipe.fromJson(el),
    popularRecipes.add(recipe),

  });




  _popularLoading = false;
  notifyListeners();
}

Future fetchRecipesByCategory(String category) async {

  _loading = true;
  recipes.clear();
  String url = "https://datascienceplc.com/api/ds_her/v1/recipe/popular?page=1&category=bread&per_page=15&category=$category";

  Dio dio = Dio();
  final response = await dio.get(url);

  // var result = jsonDecode(response.data);

  Recipe recipe;
  response.data["recipes"].forEach((el) async => {
    recipe = Recipe.fromJson(el),
    recipes.add(recipe),

  });



  _loading = false;
  notifyListeners();
}

Future fetchRecipesBySearch(String query) async {

  _loading = true;
  recipes.clear();
  String url = "https://datascienceplc.com/api/ds_her/v1/recipe/popular?page=1&per_page=15&category=$query";

  Dio dio = Dio();
  final response = await dio.get(url);

  // var result = jsonDecode(response.data);

  Recipe recipe;
  response.data["recipes"].forEach((el) async => {
    recipe = Recipe.fromJson(el),
    recipes.add(recipe),

  });

  _loading = false;
  notifyListeners();
}

Future searchRecipes(String query) async{
   
String queryData = query == "" ? "a" : query;

  _loading = true;
  recipes.clear();
  String url = "https://datascienceplc.com/api/ds_her/v1/recipe/search?page=1&per_page=10&query=$queryData";
  // String url = "https://datascienceplc.com/api/ds_her/v1/recipe/popular?page=1&category=bread&per_page=15&category=$queryData";
  Dio dio = Dio();
  final response = await dio.get(url);

  Recipe recipe;
  print("from search recipes provider");
  print(response.data["recipes"]);
  response.data["recipes"].forEach((el) async => {
    recipe = Recipe.fromJson(el),
    recipes.add(recipe)
  });
  _loading = false;
  notifyListeners();

  
}


 
}