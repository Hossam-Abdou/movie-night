import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_night/feature/category/model/category_movie_model.dart';
import 'package:movie_night/feature/category/model/movie_genre_model.dart';
import 'package:movie_night/utils/constants/constants.dart';
import 'package:movie_night/utils/end_points/end_points.dart';
import 'package:http/http.dart' as http;
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  static CategoryCubit get(context) => BlocProvider.of(context);

  MoviesGenresModel? moviesGenresModel;

  CategoryMovieModel? categoryMovieModel;

  getCategoryMovies(genreId) async {
    emit(CategoryMovieLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      EndPoints.discoverMovie,
      {
        'language': 'en',
        'with_genres': genreId,
      },
    );

    try {
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer ${Constants.apiKey}',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        categoryMovieModel = CategoryMovieModel.fromJson(
          jsonDecode(response.body),
        );
        emit(CategoryMovieSuccessState());
      } else {
        emit(CategoryMovieErrorState());
      }
    } catch (error) {
      emit(CategoryMovieErrorState());
      debugPrint(error.toString());
      // print(error.toString());
    }
  }

  getMovieGenres() async {
    emit(GetMoviesGenresLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      EndPoints.movieGenres,
      {
        'language': 'en',
      },
    );

    try {
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer ${Constants.apiKey}',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        moviesGenresModel = MoviesGenresModel.fromJson(
          jsonDecode(response.body),
        );
        emit(GetMoviesGenresSuccessState());
      } else {
        emit(GetMoviesGenresErrorState());
      }
    } catch (error) {
      emit(GetMoviesGenresErrorState());
      // print(error.toString());
    }
  }


}
