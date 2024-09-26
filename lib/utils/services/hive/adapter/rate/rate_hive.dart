// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
//
// @HiveType(typeId: 3)
// class HiveRate extends HiveObject {
//   @HiveField(0)
//   String? title;
//
//   @HiveField(1)
//   int? id;
//
//   @HiveField(2)
//   String? posterPath;
//
//   @HiveField(3)
//   double? voteAverage;
//
//   // Add a rating field
//   @HiveField(4)
//   double? rating;
//
//   HiveRate({
//     this.title,
//     this.id,
//     this.posterPath,
//     this.voteAverage,
//     this.rating,  // Initialize the rating field
//   });
// }
//
// class MovieRateManager {
//   Future<void> rateMovie({
//     required String? title,
//     required int? id,
//     required String? posterPath,
//     required double? voteAverage,
//     required double? rating,
//   }) async {
//     final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
//
//     // Open Hive box for ratings
//     var ratingBox = await Hive.openBox<HiveRate>('ratingBox', path: appDocumentsDir.path);
//
//     // Create a new HiveRate object with rating
//     var ratedMovie = HiveRate(
//       title: title,
//       id: id,
//       posterPath: posterPath,
//       voteAverage: voteAverage,
//       rating: rating, // Set the rating
//     );
//
//     // Check if the movie is already rated
//     var existingMovieIndex = ratingBox.values.toList().indexWhere((movie) => movie.id == id);
//
//     if (existingMovieIndex != -1) {
//       // Update the rating for an existing movie
//       ratingBox.putAt(existingMovieIndex, ratedMovie);
//       debugPrint('Updated rating for movie ID: $id to $rating');
//     } else {
//       // Add the new rating to the box
//       await ratingBox.add(ratedMovie);
//       debugPrint('Added rating for movie ID: $id with rating: $rating');
//     }
//   }
//
// // Retrieve all rated movies
//   Future<List<HiveRate>> getRatedMovies() async {
//     final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
//
//     // Open the Hive box for ratings
//     var ratingBox = await Hive.openBox<HiveRate>('ratingBox', path: appDocumentsDir.path);
//
//     // Retrieve all rated movies from the box
//     List<HiveRate> ratedMovies = ratingBox.values.toList();
//
//     return ratedMovies;
//   }
// }