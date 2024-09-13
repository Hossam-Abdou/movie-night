
import 'package:movie_night/feature/home/model/results_model.dart';

class PopularMoviesModel {
  PopularMoviesModel({
      this.page, 
      this.results, 
      this.totalPages, 
      this.totalResults,});

  PopularMoviesModel.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;


}

