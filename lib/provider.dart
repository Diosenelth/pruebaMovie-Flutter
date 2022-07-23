
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pruebamovie_flutter/Movie.dart';
import 'MovieRes.dart';
import 'package:http/http.dart' as http;

var page = 1;
var url = "https://api.themoviedb.org/3/";
var apiKey = "cd221c9c9cdc3e0f8e4969a04e9dfc45";
var client = http.Client();

class ProviderMovie extends ChangeNotifier{
  List<Movie>? movies;

  Future consultar() async{
    var mov = await obtenerMovies();
    if (mov.results.isNotEmpty){
      if(movies==null){
        movies=[];
        movies=mov.results.cast<Movie>();
        notifyListeners();
      }
      // else{
        // movies?.addAll(mov.results);
        // notifyListeners();
      // }
    }
  }

  Future<MovieRes> obtenerMovies() async {
    var response = await client.post(Uri.parse(
        "${url}movie/popular?page=$page&api_key=$apiKey&language=es&countries=CO"));
    if (response.statusCode == 200) {
      page++;
      final parsed = jsonDecode(response.body);
      return MovieRes.fromJson(parsed);
    }
    else{
      return MovieRes(page: 0, results: [], totalPages: 0, totalResults: 0);
    }
  }
}