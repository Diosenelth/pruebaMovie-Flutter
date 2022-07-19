
import 'dart:convert';

import 'Movie.dart';

MovieRes movieResFromJson(String str) => MovieRes.fromJson(json.decode(str));

class MovieRes {
  late final int page;
  late final List<Movie> results;
  late final int totalPages;
  late final int totalResults;

  MovieRes({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults
});

  static fromJson(Map<String, dynamic> json) => MovieRes(
    page: json["page"],
    results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}

