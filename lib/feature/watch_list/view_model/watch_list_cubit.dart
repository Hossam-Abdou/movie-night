import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie_night/feature/watch_list/model/AddRateModel.dart';
import 'package:movie_night/feature/watch_list/model/DeleteRateModel.dart';
import 'package:movie_night/feature/watch_list/model/GetProfleModel.dart';
import 'package:movie_night/feature/watch_list/model/GetRatedMovies.dart';
import 'package:movie_night/feature/watch_list/model/watch_list_model.dart';
import 'package:movie_night/utils/constants/constants.dart';
import 'package:movie_night/utils/end_points/end_points.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../../utils/services/hive/adapter/hive_adapter.dart';
part 'watch_list_state.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit() : super(WatchListInitial());

  static WatchListCubit get(context) => BlocProvider.of(context);

  WatchListModel? watchListModel;
  GetProfileModel? getProfileModel;
  GetRatedMoviesModel? getRatedMoviesModel;
  AddRateModel? addRateModel;
  DeleteRateModel? deleteRateModel;

  List<HiveWatchList> movies = [];
  List<HiveRate> moviesRate = [];
  String boxName = 'myBox';
  String rateBoxName = 'ratingBox';
  double rating = 0.0;

  Future<void> loadMovies() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    var box = await Hive.openBox<HiveWatchList>(boxName, path: appDocumentsDir.path);
    movies = box.values.toList();
    emit(LoadMoviesState());
  }
  Future<void> loadRateMovies() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    var boxRate = await Hive.openBox<HiveRate>(rateBoxName, path: appDocumentsDir.path);
    moviesRate = boxRate.values.toList();
    emit(LoadRateMoviesState());
  }

  Future<void> saveMovie(HiveWatchList movie) async {
    final box = await Hive.openBox<HiveWatchList>(boxName);

    // Check if the movie already exists
    final existingIndex =
        box.values.toList().indexWhere((e) => e.id == movie.id);
    if (existingIndex == -1) {
      await box.add(movie);
    }
    loadMovies();
  }

  Future<void> removeMovie(int index) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    var box = await Hive.openBox<HiveWatchList>(boxName, path: appDocumentsDir.path);
    await box.deleteAt(index);
    debugPrint('Movie removed at index: $index');
    loadMovies(); // Reload movies to update the list
  }
  Future<void> deleteRate(int id) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    var boxRate = await Hive.openBox<HiveRate>(rateBoxName, path: appDocumentsDir.path);
    final index = boxRate.values.toList().indexWhere((item) => item.id == id);
    if (index != -1) {
      await boxRate.deleteAt(index);
      debugPrint('Movie rate removed at index: $index');
    } else {
      debugPrint('No movie rate found with ID: $id');
    }
    loadRateMovies(); // Reload rates to update the list
    emit(DeleteRatedMoviesSuccessState()); // Emit success state
  }

  Future<bool> isInWatchList(int id) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    var box =
        await Hive.openBox<HiveWatchList>(boxName, path: appDocumentsDir.path);

    return box.values.any((movie) => movie.id == id);
  }

  getWatchList() async {
    emit(GetMoviesWatchListLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      '${EndPoints.movieWatchList}/${Constants.accountID}/watchlist/movies',
      {
        'language': 'en',
        // 'account_id': Constants.accountID,
      },
    );

    try {
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer ${Constants.apiKey}',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        watchListModel = WatchListModel.fromJson(
          jsonDecode(response.body),
        );
        emit(GetMoviesWatchListSuccessState());
      } else {
        emit(GetMoviesWatchListErrorState());
      }
    } catch (error) {
      emit(GetMoviesWatchListErrorState());
      // debugPrint(error.toString());
    }
  }

  addToWatchList({id, required bool isWatchList}) async {
    emit(AddMoviesWatchListLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      '${EndPoints.movieWatchList}/${Constants.accountID}/watchlist',
      {
        'language': 'en',
      },
    );

    try {
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer ${Constants.apiKey}',
          'Accept': 'application/json',
          'Content-Type': 'application/json', // Set content type to JSON
        },
        body: jsonEncode({
          'media_type': 'movie',
          'media_id': id,
          'watchlist': isWatchList,
        }),
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        watchListModel = WatchListModel.fromJson(
          jsonDecode(response.body),
        );
        emit(AddMoviesWatchListSuccessState());
        getWatchList();
      } else {
        emit(AddMoviesWatchListErrorState());
      }
    } catch (error) {
      emit(AddMoviesWatchListErrorState());
      debugPrint('Error: ${error.toString()}');
    }
  }

  getProfileData() async {
    emit(GetProfileDataLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      '${EndPoints.movieWatchList}/${Constants.accountID}',
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
        getProfileModel = GetProfileModel.fromJson(
          jsonDecode(response.body),
        );
        emit(GetProfileDataSuccessState());
      } else {
        emit(GetProfileDataErrorState());
      }
    } catch (error) {
      emit(GetProfileDataErrorState());
      // print(error.toString());
    }
  }

  getRatedMovies() async {
    emit(GetRatedMoviesLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      '${EndPoints.movieWatchList}/${Constants.accountID}/rated/movies',
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
        getRatedMoviesModel = GetRatedMoviesModel.fromJson(
          jsonDecode(response.body),
        );
        emit(GetRatedMoviesSuccessState());
      } else {
        emit(GetRatedMoviesErrorState());
      }
    } catch (error) {
      emit(GetRatedMoviesErrorState());
      // print(error.toString());
    }
  }


  addRate({required movieId, required rateValue}) async {
    emit(AddRatedMoviesLoadingState());
    Uri uri = Uri.https(
      EndPoints.baseUrl,
      '${EndPoints.movieDetails}/$movieId/rating',
      {
        'language': 'en',
      },
    );

    try {
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer ${Constants.apiKey}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body:jsonEncode({
          "value": rateValue

        }),
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        addRateModel = AddRateModel.fromJson(
          jsonDecode(response.body),
        );
        emit(AddRatedMoviesSuccessState());
        getRatedMovies();
      } else {
        emit(AddRatedMoviesErrorState());
      }
    } catch (error) {
      emit(AddRatedMoviesErrorState());
      debugPrint('Error: ${error.toString()}');
    }
  }

  // deleteRate(movieId) async {
  //   emit(DeleteRatedMoviesLoadingState());
  //   Uri uri = Uri.https(
  //     EndPoints.baseUrl,
  //     '${EndPoints.movieDetails}/$movieId/rating',
  //     {
  //       'language': 'en',
  //     },
  //   );
  //
  //   try {
  //     final response = await http.delete(
  //       uri,
  //       headers: {
  //         'Authorization': 'Bearer ${Constants.apiKey}',
  //         'Accept': 'application/json',
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //
  //     debugPrint('Response status: ${response.statusCode}');
  //     debugPrint('Response body: ${response.body}');
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       deleteRateModel = DeleteRateModel.fromJson(
  //         jsonDecode(response.body),
  //       );
  //       emit(DeleteRatedMoviesSuccessState());
  //       await getRatedMovies();
  //     } else {
  //       emit(DeleteRatedMoviesErrorState());
  //     }
  //   } catch (error) {
  //     emit(DeleteRatedMoviesErrorState());
  //     debugPrint('Error: ${error.toString()}');
  //   }
  // }


}
