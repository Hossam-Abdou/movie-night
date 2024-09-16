import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_night/feature/home/model/results_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  static const String boxName = 'watchList';
  static const String newBox = 'newBox';

  // Save the movie to the watchlist
  static Future<void> saveMovie(Results movie) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final box = await Hive.openBox<Results>(newBox, path: appDocumentsDir.path,);

    await box.add(movie); // Add movie to the watchlist
    debugPrint('movie added : $movie');
    debugPrint('hello : ');
  }

  // Retrieve all watchlist movies
  static Future<List<Results>> getMovies() async {
    final box = await Hive.openBox<Results>(newBox,);
    return box.values.toList(); // Get all movies as a list
  }

  // Remove a movie from the watchlist by index or id
  static Future<void> removeMovie(int index) async {
    final box = await Hive.openBox<Results>(boxName);
    await box.deleteAt(index);
  }

  // Check if a movie is already in the watchlist by id
  static Future<bool> isInWatchList(int id) async {
    final box = await Hive.openBox<Results>(boxName);
    return box.values.any((movie) => movie.id == id);
  }
}
