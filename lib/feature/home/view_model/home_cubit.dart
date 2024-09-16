import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_night/feature/home/model/MovieTrailerModel.dart';
import 'package:movie_night/feature/home/model/popular_movies_model.dart';
import 'package:movie_night/feature/home/model/movie_details_model.dart';
import 'package:movie_night/feature/home/model/new_release_model.dart';
import 'package:movie_night/feature/home/model/search_model.dart';
import 'package:movie_night/feature/home/model/similar_movies_model.dart';
import 'package:movie_night/feature/home/model/top_rated_model.dart';
import 'package:movie_night/utils/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:movie_night/utils/end_points/end_points.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  NewReleaseModel? newReleaseModel;
  TopRatedModel? topRatedModel;
  PopularMoviesModel? popularMoviesModel;
  MoviesDetailsModel? moviesDetailsModel;
  SimilarMoviesModel? similarMoviesModel;
  SearchModel? searchModel;
  MovieTrailerModel? movieTrailerModel;
  //
  // String? currentLanguage;
  //
  // void toggleLanguage(context) {
  //   if (currentLanguage == 'ar') {
  //     currentLanguage = 'en';
  //     emit(LanguageChange());
  //   } else {
  //     currentLanguage = 'ar';
  //     emit(LanguageChange());
  //   }
  // }
  //
  // void changeLang(BuildContext context) {
  //   if (context.locale.languageCode == 'en') {
  //     context.setLocale(const Locale('ar'));
  //     // SharedPrefrenceHelper.saveData(key: CachedKeys.currentThemeMode, value: 'ar');
  //
  //     emit(LanguageChange());
  //
  //   } else {
  //     context.setLocale(const Locale('en'));
  //     currentLanguage = 'en';
  //     // SharedPrefrenceHelper.saveData(key: CachedKeys.currentThemeMode, value: 'en');
  //
  //     emit(LanguageChange());
  //   }
  //
  //   getPopularMovies();
  //   getRecommendedMovies();
  //   getNewReleasesMovies();
  //
  // }
  double rating = 0.0;
getRatedMovies(value)  {
  rating = value;
  emit(AddRateState());
}
  getPopularMovies() async {
    emit(PopularLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      EndPoints.popular,
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
        debugPrint('Response: ${response.body}');
        popularMoviesModel =
            PopularMoviesModel.fromJson(jsonDecode(response.body));
        emit(PopularSuccessState());
      } else {
        debugPrint('Error: Response status ${response.statusCode}');
        emit(PopularErrorState());
      }
    } catch (error, stacktrace) {
      debugPrint('Error: $error');
      debugPrint('Stacktrace: $stacktrace');
      emit(PopularErrorState());
    }
  }

  getNewReleasesMovies() async {
    emit(NewReleaseLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      EndPoints.upcomingMovies,
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
        newReleaseModel = NewReleaseModel.fromJson(
          jsonDecode(response.body),
        );
        emit(NewReleaseSuccessState());
      } else {
        emit(NewReleaseErrorState());
      }
    } catch (error) {
      emit(NewReleaseErrorState());
    }
  }

  getRecommendedMovies() async {
    emit(TopRatedLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      EndPoints.topRated,
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
        topRatedModel = TopRatedModel.fromJson(
          jsonDecode(response.body),
        );
        emit(TopRatedSuccessState());
      } else {
        emit(TopRatedErrorState());
      }
    } catch (error) {
      emit(TopRatedErrorState());
    }
  }

  searchMovies(String query) async {
    emit(SearchMovieLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      EndPoints.searchMovie,
      {
        'language': 'en',
        'query': query,
      },
    );

    try {
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer ${Constants.apiKey}',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        searchModel = SearchModel.fromJson(
          jsonDecode(response.body),
        );
        emit(SearchMovieSuccessState());
      } else {
        emit(SearchMovieErrorState());
      }
    } catch (error) {
      emit(SearchMovieErrorState());
      debugPrint(error.toString());
      // print(error.toString());
    }
  }

  getMovieTrailer(movieId) async {
    emit(GetMovieTrailerLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      '${EndPoints.movieDetails}/$movieId/videos',
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
        movieTrailerModel = MovieTrailerModel.fromJson(
          jsonDecode(response.body),
        );
        emit(GetMovieTrailerSuccessState());
      } else {
        emit(GetMovieTrailerErrorState());
      }
    } catch (error) {
      emit(GetMovieTrailerErrorState());
      debugPrint(error.toString());
      // print(error.toString());
    }
  }


  getMovieDetails(id) async {
    emit(GetMovieDetailsLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      '${EndPoints.movieDetails}/$id',
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
        moviesDetailsModel = MoviesDetailsModel.fromJson(
          jsonDecode(response.body),
        );
        emit(GetMovieDetailsSuccessState());
      } else {
        emit(GetMovieDetailsErrorState());
      }
    } catch (error) {
      emit(GetMovieDetailsErrorState());
    }
  }

  getSimilarMovie(id) async {
    emit(GetSimilarMovieLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      '${EndPoints.movieDetails}/$id/similar',
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
        similarMoviesModel = SimilarMoviesModel.fromJson(
          jsonDecode(response.body),
        );
        emit(GetSimilarMovieSuccessState());
      } else {
        emit(GetSimilarMovieErrorState());
      }
    } catch (error) {
      emit(GetSimilarMovieErrorState());
      // print(error.toString());
    }
  }

  // PodPlayerController? controller;

  // void initializeVideo(videoKey) {
  //   controller = PodPlayerController(
  //     playVideoFrom: PlayVideoFrom.youtube(
  //       'https://youtu.be/$videoKey',
  //     ),
  //     podPlayerConfig: const PodPlayerConfig(
  //       autoPlay: false,
  //       isLooping: false,
  //     ),
  //   )..initialise();
  //   emit(gettrailer());
  // }

}
